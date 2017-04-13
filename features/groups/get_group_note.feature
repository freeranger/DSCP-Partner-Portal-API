Feature: Get a Note for a Group
  In order to manage the Notes for a Group
  I need to be able to retrieve them.


  Background:
    Given the following user is registered:
      | id | first_name       | last_name      | email                       | password  |
      | 1  | Charles          | Xavier         | x@westchester.ny            | jeanrules |

    And the system knows about the following group:
      | id  | name         | description |
      | 123 | The Avengers | Earth's mightiest heroes |

    And the system knows about the following note:
      | id  | content                       | group_id | user_id | created_at               | updated_at               |
      | 456 | I note that nothing is noted. | 123      | 1       | 2017-04-11T22:21:48.314Z | 2017-04-11T22:21:48.314Z |

    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: Get a group note (unauthenticated client)
    Given the client is not authenticated
    When the client sends a GET request to /groups/123/notes/456
    Then a 401 status code is returned


  Scenario: Get a group note that exists
            Returns content, created_at, updated_at, user name, and links to self and related resources
    Given the client sends a GET request to /groups/123/notes/456
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should contain a single note
    And the JSON should contain:
      """
          { "content": "I note that nothing is noted.",
            "created_at": "2017-04-11T22:21:48.314Z",
            "updated_at": "2017-04-11T22:21:48.314Z",
            "user": { "first_name": "Charles", "last_name": "Xavier",
              "_links" : {
                "self": { "href": "/users/1" }
              }
            },
            "_links": {
              "self": { "href": "/groups/123/notes/456" }
            }
          }
      """


  Scenario: Get a group note that exists for another user
            Returns content, created_at, updated_at, user name, and links to self and related resources
    Given the following user is registered:
      | id | first_name       | last_name      | email                       | password  |
      | 2  | Scott            | Summers         | slim@xmen.org              | jean4ever |
    And the system knows about the following note:
      | id  | content                         | group_id | user_id | created_at               | updated_at               |
      | 789 | I note that something is noted. | 123      | 2       | 2017-04-11T22:22:48.314Z | 2017-04-11T22:22:48.314Z |
    Given the client sends a GET request to /groups/123/notes/789
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should contain a single note
    And the JSON should contain:
      """
          { "content": "I note that something is noted.",
            "created_at": "2017-04-11T22:22:48.314Z",
            "updated_at": "2017-04-11T22:22:48.314Z",
            "user": { "first_name": "Scott", "last_name": "Summers",
              "_links" : {
                "self": { "href": "/users/2" }
              }
            },
            "_links": {
              "self": { "href": "/groups/123/notes/789" }
            }
          }
      """


  Scenario: Get a group note for a non existing group
    Given the client sends a GET request to /groups/9999/notes/456
    Then a 404 status code is returned


  Scenario: Get group note that does not exist
    Given the client sends a GET request to /groups/123/notes/789
    Then a 404 status code is returned