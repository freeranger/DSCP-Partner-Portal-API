Feature: List Groups
  In order to manage groups
  I need to be able to list them.

  Background:
    Given the following user is registered:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |
    And the client authenticates as x@westchester.ny/jeanrules

    And the system knows about the following groups:
      | id  | name         | description                 |
      | 123 | The Avengers | Earth's mightiest heroes    |
      | 456 | The Fantastic Four | Marvel's first family |

    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: List groups (unauthenticated client)
    Given the client is not authenticated
    When the client sends a GET request to /groups
    Then a 401 status code is returned


  Scenario: List groups
            Returns group names and self links only
    Given the client sends a GET request to /groups
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have at least two groups
    And the JSON should contain:
      """
        [
          { "name": "The Avengers",
              "_links": {
                "self" : { "href": "/groups/123" }
              }
          },
          { "name": "The Fantastic Four",
              "_links": {
                "self" : { "href": "/groups/456" }
              }
           }
        ]
      """
    And the JSON should not contain:
    """
       {"description":"Earth's mightiest heroes"}
    """
    And the JSON should not contain:
    """
        { "_links": {
          "contacts" : { "href": "/groups/123/contacts" }
        }  }
    """
    And the JSON should not contain:
    """
        { "_links": {
          "links" : { "href": "/groups/123/links" }
        }  }
    """
    And the JSON should not contain:
    """
        { "_links": {
          "notes" : { "href": "/groups/123/notes" }
        }  }
    """