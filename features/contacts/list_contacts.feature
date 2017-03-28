Feature: List Contacts (authenticated client)
  In order to manage contacts
  I need to be able to list them.

  Background:
    Given the system knows about the following user:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |

    And the system knows about the following contacts:
      | first_name       | last_name      | email                     |
      | Reed             | Richards       | mrfantastic@ff.com        |
      | Jessica          | Jones          | jewel@brooklyn.ny         |

    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: List contacts (unauthenticated client)
    Given the client is not authenticated
    When the client sends a GET request to /contacts
    Then a 401 status code is returned


  Scenario: List contacts
    Given the client sends a GET request to /contacts
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have at least two contacts
    And the JSON should contain:
      """
        [
          { "first_name": "Reed", "last_name": "Richards", "email": "mrfantastic@ff.com" },
          { "first_name": "Jessica", "last_name": "Jones", "email": "jewel@brooklyn.ny" }
        ]
      """
    
  