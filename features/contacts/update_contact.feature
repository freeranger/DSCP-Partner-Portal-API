Feature: Update Contacts
  In order to manage contacts
  I need to be able to update them.

  Background:
    Given the system knows about the following user:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |

    And the system knows about the following contact:
      | id  | first_name       | last_name      | email          |
      | 123 | Bruce            | Banner         | hulk@smash.org |

    And the client authenticates as x@westchester.ny/jeanrules

  Scenario: Update a contact (unauthenticated client)
    Given the client is not authenticated
    When the client sends a PUT request to /contacts/123:
      """
          { "first_name": "David", "last_name": "Banner", "email": "hulk@smash.org" }
      """
    Then a 401 status code is returned


  Scenario: Update an existing contact
    Given the client sends a PUT request to /contacts/123:
      """
          { "first_name": "David", "last_name": "Banner", "email": "hulk@smash.org" }
      """
    Then a 204 status code is returned
    And the contact is updated with:
      | id  | first_name       | last_name      | email          |
      | 123 | David            | Banner         | hulk@smash.org |


  Scenario: Update a non existing contact
    Given the client sends a PUT request to /contacts/999:
      """
          { "first_name": "David", "last_name": "Banner", "email": "hulk@smash.org" }
      """
    Then a 404 status code is returned


  Scenario: Update an existing contact with an email already in use
    Given the system knows about the following contact:
      | id  | first_name       | last_name      | email               |
      | 10  | Peter            | Parker         | spidey@webheads.org |
      | 11  | Miles            | Morales        | spidey@webheads.com |
    When the client sends a PUT request to /contacts/11:
      """
          { "first_name": "Miles", "last_name": "Morales", "email": "spidey@webheads.org" }
      """
    Then a 422 status code is returned
    And the response should be JSON
    And the JSON should contain:
      """
        { "email":["has already been taken"] }
      """
