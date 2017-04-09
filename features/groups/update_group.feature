Feature: Update Groups
  In order to manage groups
  I need to be able to update them.

  Background:
    Given the following user is registered:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |

    And the system knows about the following group:
      | id  | name         | description |
      | 123 | The Avengers | Earth's mightiest heroes |

    And the client authenticates as x@westchester.ny/jeanrules

  Scenario: Update a group (unauthenticated client)
    Given the client is not authenticated
    When the client sends a PUT request to /groups/123:
      """
          { "name": "The Avengers", "description": "Earth's mightiest heroes" }
      """
    Then a 401 status code is returned


  Scenario: Update an existing group
    Given the client sends a PUT request to /groups/123:
      """
          { "name": "The Avengers", "description": "Earth's mightiest heroes!!!" }
      """
    Then a 204 status code is returned
    And the group is updated with:
      | id  | name         | description                 |
      | 123 | The Avengers | Earth's mightiest heroes!!! |


  Scenario: Update a non existing group
    Given the client sends a PUT request to /groups/999:
      """
          { "name": "The JLA", "description": "Not as good as the Avengers" }
      """
    Then a 404 status code is returned


  Scenario: Update an existing group with a name already in use
    Given the system knows about the following group:
      | id  | name         | description                 |
      | 456 | The Fantastic Four | Marvel's first family |
    When the client sends a PUT request to /groups/456:
      """
          { "name": "The Avengers" }
      """
    Then a 422 status code is returned
    And the response should be JSON
    And the JSON should contain:
      """
        { "name":["has already been taken"] }
      """
