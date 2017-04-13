Feature: Update Notes for a Group
  In order to manage the Notes for a Group
  I need to be able to update existing notes.

  Background:
    Given the following users are registered:
      | id | first_name       | last_name      | email                       | password  |
      | 1  |Charles          | Xavier          | x@westchester.ny            | jeanrules |
      | 2  | Scott            | Summers        | slim@xmen.org               | jean4ever |

    And the system knows about the following group:
      | id  | name         | description |
      | 123 | The Avengers | Earth's mightiest heroes |

    And the system knows about the following note:
      | id  | content                       | group_id | user_id |
      | 456 | I note that nothing is noted. | 123      | 1       | 

    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: Update an existing note (unauthenticated)
    Given the client is not authenticated
    When the client sends a PUT request to /groups/123/notes/456:
      """
         { "content": "I note that something is noted." }
      """
    Then a 401 status code is returned


  Scenario: Update an existing note
    Given the client sends a PUT request to /groups/123/notes/456:
      """
         { "content": "I note that something is noted." }
      """
    Then a 204 status code is returned
    And the note is updated with:
      | id  | content                         |
      | 456 | I note that something is noted. |


  Scenario: Update a non existing note
    Given the client sends a PUT request to /groups/123/notes/9999:
      """
         { "content": "I note that something is noted." }
      """
    Then a 404 status code is returned


  Scenario: Update a note in a group that does not exist
    Given the client sends a PUT request to /groups/9999/notes/456:
      """
         { "content": "I note that something is noted." }
      """
    Then a 404 status code is returned

  Scenario: Update an existing note belonging to another user
    And the system knows about the following note:
      | id  | content                         | group_id | user_id |
      | 789 | I note that something is noted. | 123      | 2       |
    When the client sends a PUT request to /groups/123/notes/789:
      """
         { "content": "I note that everything is noted." }
      """
    Then a 403 status code is returned
    And the note has:
      | id | content                         |
      | 789| I note that something is noted. |
