Feature: Delete Contacts
  In order to manage contacts
  I need to be able to delete them.

  Background:
    Given the system knows about the following user:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |

    And the system knows about the following contact:
      | id  | first_name       | last_name      | email          |
      | 123 | Bruce            | Banner         | hulk@smash.org |

  Scenario: Delete a contact (unauthenticated client)
    When the client sends a DELETE request to /contacts/123
    Then a 401 status code is returned

    
  Scenario: Delete an existing contact (authenticated client)
    Given the client authenticates as x@westchester.ny
    When the client sends a DELETE request to /contacts/123
    Then a 204 status code is returned
    And the contact id 123 does not exist


  Scenario: Delete an non existing contact (authenticated client)
    Given the client authenticates as x@westchester.ny
    When the client sends a DELETE request to /contacts/9999
    Then a 404 status code is returned