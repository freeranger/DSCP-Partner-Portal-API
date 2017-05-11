Feature: Search Partners
  In order to find the partners I want
  I need to be able to search them.
  The search has all the features of a contacts search, but is limited to those contacts who are also partners

  Background:
    Given the following user is registered:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |

    And the system knows about the following contacts:
      | id | first_name       | last_name      | email                     | business_name          | city          | partner |
      | 1  | Warren           | Worthington    | angel@w3.org              | Worthington Industries | North Salem   | true    |
      | 2  | Jessica          | Jones          | jewel@brooklyn.ny         | Alias Investigations   | New York      | false   |
      | 3  | Jean             | Grey           | jean@grey.me              | Uncanny X-Men R Us     | North Salem   | true    |
      | 4  | Richard          | Jones          | abomb@smash.org           | Hulk, Inc              | Scarsdale     | true    |

    And the client authenticates as x@westchester.ny/jeanrules

  Scenario: Search partners (unauthenticated)
    Given the client is not authenticated
    When the client sends a GET request to /partners?search=Je
    Then a 401 status code is returned


  Scenario: Search partners resulting in no match
            Jessica Jones is a contact but not a partner
    Given the client sends a GET request to /partners?search=Jessica
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly no contacts


  Scenario: Search partners matching on first name only
    Given the client sends a GET request to /partners?search=Je
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly one contacts
    And the JSON should contain:
      """
        [
          { "first_name": "Jean", "last_name": "Grey", "email": "jean@grey.me" }
        ]
      """


  Scenario: Search partners matching on last name only
    Given the client sends a GET request to /partners?search=Jones
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly one contacts
    And the JSON should contain:
      """
        [
          { "first_name": "Richard", "last_name": "Jones", "email": "abomb@smash.org" }
        ]
      """



  Scenario: Search partners matching on city
    Given the client sends a GET request to /partners?search=Salem
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly two contacts
    And the JSON should contain:
      """
        [
          { "first_name": "Warren", "last_name": "Worthington", "email": "angel@w3.org" },
          { "first_name": "Jean", "last_name": "Grey", "email": "jean@grey.me" }
        ]
      """