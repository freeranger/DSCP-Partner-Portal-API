Feature: Delete Notes for a Group
  In order to manage the Notes for a Group
  I need to be able to delete existing notes.

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


  Scenario: Delete a note (unauthenticated client)
    Given the client is not authenticated
    When the client sends a DELETE request to /groups/123/notes/456
    Then a 401 status code is returned


  Scenario: Delete an existing link
    Given the client sends a DELETE request to /groups/123/notes/456
    Then a 204 status code is returned
    And the note id 456 does not exist


  Scenario: Delete an non existing note
    Given the client sends a DELETE request to /groups/123/notes/9999
    Then a 404 status code is returned


  Scenario: Delete an existing note belonging to another user
    And the system knows about the following note:
      | id  | content                         | group_id | user_id |
      | 789 | I note that something is noted. | 123      | 2       |
    When the client sends a DELETE request to /groups/123/notes/789
    Then a 403 status code is returned
    And the note id 789 does exist