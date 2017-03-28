Feature: Get Contacts
  In order to manage contacts
  I need to be able to retrieve them.

  Background:
    Given the system knows about the following user:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |

    And the system knows about the following contact:
      | id  | first_name       | last_name      | email          |
      | 123 | Bruce            | Banner         | hulk@smash.org |

    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: Get a contact  (unauthenticated client)
    Given the client is not authenticated
    When the client sends a GET request to /contacts/123
    Then a 401 status code is returned


  Scenario: Get a contact (authenticated client)
    Given the client sends a GET request to /contacts/123
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should contain a single contact
    And the JSON should contain:
      """
          { "first_name": "Bruce", "last_name": "Banner", "email": "hulk@smash.org" }
      """


  Scenario: Get a contact which does not exist
    Given the client sends a GET request to /contacts/9999
    Then a 404 status code is returned

