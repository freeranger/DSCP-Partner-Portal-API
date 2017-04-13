Feature: Get Group
  In order to manage groups
  I need to be able to retrieve them.

  Background:
    Given the following user is registered:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |

    And the system knows about the following groups:
      | id  | name         | description |
      | 123 | The Avengers | Earth's mightiest heroes |
      | 456 | The Fantastic Four | Marvel's first family |

    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: Get a group  (unauthenticated client)
    Given the client is not authenticated
    When the client sends a GET request to /groups/123
    Then a 401 status code is returned


  Scenario: Get a group
            Returns name, description, and links to self and related resources
    Given the client sends a GET request to /groups/123
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should contain a single group
    And the JSON should contain:
      """
          { "name": "The Avengers",
            "description": "Earth's mightiest heroes",
              "_links": {
                "self": { "href": "/groups/123" },
                "links": { "href": "/groups/123/links" },
                "notes": { "href": "/groups/123/notes" }
              }
          }
      """


  Scenario: Get a group which does not exist
    Given the client sends a GET request to /groups/9999
    Then a 404 status code is returned

