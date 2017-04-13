Feature: List Notes for a Group
  In order to manage the Notes for a Group
  I need to be able to list them.


  Background:
    Given the following users are registered:
      | id | first_name       | last_name      | email                       | password  |
      | 1  | Charles          | Xavier         | x@westchester.ny            | jeanrules |
      | 2  | Scott            | Summers        | slim@xmen.org               | jean4ever |

    And the system knows about the following group:
      | id  | name         | description |
      | 123 | The Avengers | Earth's mightiest heroes |

    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: List group notes (unauthenticated client)
    Given the client is not authenticated
    When the client sends a GET request to /groups/123/notes
    Then a 401 status code is returned


  Scenario: List notes for a non existing group
    Given the client sends a GET request to /groups/9999/notes
    Then a 404 status code is returned


  Scenario: List group notes where the group has no notes
    Given the client sends a GET request to /groups/123/notes
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly zero notes


  Scenario: List group notes where the group has notes from different users
            Returns content, created_at, updated_at, user name, and links to self and related resources
    Given the system knows about the following notes:
      | id  | content                         | group_id | user_id | created_at               | updated_at               |
      | 456 | I note that nothing is noted.   | 123      | 1       | 2017-04-11T22:21:48.314Z | 2017-04-11T22:21:48.314Z |
      | 789 | I note that something is noted. | 123      | 2       | 2017-04-11T22:22:48.314Z | 2017-04-11T22:22:48.314Z |
    When the client sends a GET request to /groups/123/notes
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly two notes
    And the JSON should contain:
      """
        [
          { "content": "I note that nothing is noted.",
            "created_at": "2017-04-11T22:21:48.314Z",
            "updated_at": "2017-04-11T22:21:48.314Z",
            "user": { "first_name": "Charles", "last_name": "Xavier",
              "_links": {
                "self": { "href": "/users/1" }
              }
            },
            "_links": {
              "self": { "href": "/groups/123/notes/456" }
            }
          },
          { "content": "I note that something is noted.",
            "created_at": "2017-04-11T22:22:48.314Z",
            "updated_at": "2017-04-11T22:22:48.314Z",
            "user": { "first_name": "Scott", "last_name": "Summers",
              "_links": {
                "self": { "href": "/users/2" }
              }
            },
            "_links": {
              "self": { "href": "/groups/123/notes/789" }
            }
          }
        ]
      """
