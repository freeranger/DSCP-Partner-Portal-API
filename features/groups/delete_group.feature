Feature: Delete Groups
  In order to manage Groups
  I need to be able to delete them.


  Background:
    Given the following user is registered:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |

    And the system knows about the following group:
      | id  | name         | description |
      | 123 | The Avengers | Earth's mightiest heroes |

    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: Delete a group (unauthenticated client)
    Given the client is not authenticated
    When the client sends a DELETE request to /groups/123
    Then a 401 status code is returned


  Scenario: Delete an existing group
    Given the client sends a DELETE request to /groups/123
    Then a 204 status code is returned
    And the group id 123 does not exist


  Scenario: Delete an non existing group
    Given the client sends a DELETE request to /groups/9999
    Then a 404 status code is returned


  Scenario: Delete a group with contacts
            The group is deleted but the contacts are not
    Given the system knows about the following contact:
      | id  | first_name       | last_name      | email          |
      | 123 | Bruce            | Banner         | hulk@smash.org |
    And the system knows about the following group:
      | id  | name         | description                 |
      | 456 | The Fantastic Four | Marvel's first family | 
    And the group contains contact id 123
    When the client sends a DELETE request to /groups/456
    Then a 204 status code is returned
    And the group id 456 does not exist
    And the contact id 123 does exist


  Scenario: Delete a group with notes
            The group and the notes are deleted
    Given the system knows about the following user:
      | id  | first_name       | last_name      | email          | password |
      | 123 | Bruce            | Banner         | hulk@smash.org | betty    |
    And the system knows about the following group:
      | id  | name         | description                 |
      | 456 | The Fantastic Four | Marvel's first family |
    And the system knows about the following note:
      | id  | content                     | user_id | group_id |
      | 789 | Bruce loves Betty la la la  | 123     | 456      |
    When the client sends a DELETE request to /groups/456
    Then a 204 status code is returned
    And the group id 456 does not exist
    And the note id 789 does not exist


  Scenario: Delete a group with links
            The group and the links are deleted
    And the system knows about the following group:
      | id  | name         | description                 |
      | 456 | The Fantastic Four | Marvel's first family |
    And the system knows about the following link:
      | id  | title                    | destination              | group_id |
      | 789 | "The Gamma Bomb Project" | http://gammabombsrus.mil | 456      |
    When the client sends a DELETE request to /groups/456
    Then a 204 status code is returned
    And the group id 456 does not exist
    And the note id 789 does not exist