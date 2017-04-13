Feature: Add a Note to a Group
  In order to manage the Notes for a Group
  I need to be able to add new notes.

  Background:
    Given the following user is registered:
      | id | first_name       | last_name      | email                       | password  |
      | 1  | Charles          | Xavier         | x@westchester.ny            | jeanrules |
    And the system knows about the following group:
      | id  | name         | description |
      | 123 | The Avengers | Earth's mightiest heroes |
    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: Add a note (unauthenticated)
    Given the client is not authenticated
    When the client sends a POST request to /groups/123/notes:
      """
         { "content": "I note that nothing is noted." }
      """
    Then a 401 status code is returned


  Scenario: Add a note to a group that does not exist
    Given the client sends a POST request to /groups/9999/notes:
      """
         { "content": "I note that nothing is noted." }
      """
    Then a 404 status code is returned


  Scenario: Add a note
    Given the client sends a POST request to /groups/123/notes:
      """
         { "content": "I note that nothing is noted." }
      """
    Then a 201 status code is returned
    And the location header points to the created note
    And the note is created with:
      | content |
      | I note that nothing is noted. |


  Scenario: Add a note when one already exists with the same content
            The duplicate note is added
    Given the system knows about the following note:
      | id  | content                       | group_id | user_id |
      | 456 | I note that nothing is noted. | 123      | 1       |
    When the client sends a POST request to /groups/123/notes:
      """
         { "content": "I note that nothing is noted." }
      """
    Then a 201 status code is returned
    And the location header points to the created note
    And the note is created with:
      | content                       |
      | I note that nothing is noted. |
    And the client sends a GET request to /groups/123/notes
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly two notes
    And the JSON should contain:
      """
        [
          { "content": "I note that nothing is noted." },
          { "content": "I note that nothing is noted." }
        ]
      """


  Scenario: Add a note with no content
    Given the client sends a POST request to /groups/123/notes:
      """
         { "content": "" }
      """
    Then a 422 status code is returned
    And the response should be JSON
    And the JSON should contain:
      """
          {"content":["can't be blank", "is too short (minimum is 25 characters)"]}
      """


  Scenario: Add a note that is too short
    Given the client sends a POST request to /groups/123/notes:
      """
         { "content": "too short" }
      """
    Then a 422 status code is returned
    And the response should be JSON
    And the JSON should contain:
      """
          {"content":["is too short (minimum is 25 characters)"]}
      """
