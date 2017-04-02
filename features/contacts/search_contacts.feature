Feature: Search Contacts
  In order to find the contacts I want
  I need to be able to search for them in multiple fields.

  Background:
    Given the following user is registered:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |

    And the system knows about the following contacts:
      | first_name       | last_name      | email                     | business_name        | street_address               | city      | state | zip   | phone |
      | Reed             | Richards       | mrfantastic@ff.org        | Fantastic Four       | Madison Avenue               | New York  | NY    | 10019 | 1800444444 |
      | Jessica          | Jones          | jewel@brooklyn.ny         | Alias Investigations | 485 W 46th Street            | New York  | NY    | 10036 | 1800555321 |
      | Richard          | Jones          | abomb@smash.org           | Hulk, Inc            | 7324 E Indian School Road    | Scarsdale | AZ    | 85321 |            |

    And the client authenticates as x@westchester.ny/jeanrules

  Scenario: Search contacts (unauthenticated client)
    Given the client is not authenticated
    When the client sends a GET request to /contacts?search=Jones
    Then a 401 status code is returned


  Scenario: Search contacts matching on last name only
    Given the client sends a GET request to /contacts?search=Jones
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly two contacts
    And the JSON should contain:
      """
        [
          { "first_name": "Jessica", "last_name": "Jones", "email": "jewel@brooklyn.ny" },
          { "first_name": "Richard", "last_name": "Jones", "email": "abomb@smash.org" }
        ]
      """


  Scenario: Search contacts matching on last name, with a mixed case query
    Given the client sends a GET request to /contacts?search=JoNEs
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly two contacts
    And the JSON should contain:
      """
        [
          { "first_name": "Jessica", "last_name": "Jones", "email": "jewel@brooklyn.ny" },
          { "first_name": "Richard", "last_name": "Jones", "email": "abomb@smash.org" }
        ]
      """


  Scenario: Search contacts matching on exact email address only
    Given the client sends a GET request to /contacts?search=mrfantastic@ff.org
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly one contact
    And the JSON should contain:
      """
        [
          { "first_name": "Reed", "last_name": "Richards", "email": "mrfantastic@ff.org" }
        ]
      """


  Scenario: Search contacts matching on an email address starting with a value
    Given the client sends a GET request to /contacts?search=mrfantastic
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly one contact
    And the JSON should contain:
      """
        [
          { "first_name": "Reed", "last_name": "Richards", "email": "mrfantastic@ff.org" }
        ]
      """

  @wip
  # this does not work with pg_search
  Scenario: Search contacts matching on an email address ending with a value
    Given the client sends a GET request to /contacts?search=org
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly two contacts
    And the JSON should contain:
      """
        [
          { "first_name": "Reed", "last_name": "Richards", "email": "mrfantastic@ff.org" },
          { "first_name": "Richard", "last_name": "Jones", "email": "abomb@smash.org" }
        ]
      """


  Scenario: Search contacts matching on business name only
    Given the client sends a GET request to /contacts?search=In
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly two contacts
    And the JSON should contain:
      """
        [
          { "first_name": "Jessica", "last_name": "Jones", "email": "jewel@brooklyn.ny", "business_name": "Alias Investigations" },
          { "first_name": "Richard", "last_name": "Jones", "email": "abomb@smash.org", "business_name": "Hulk, Inc" }
        ]
      """


  @wip
  # I don't see how this would work with a number field
  Scenario: Search contacts matching on phone number
    Given the client sends a GET request to /contacts?search=1800
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly two contacts
    And the JSON should contain:
      """
        [
          { "first_name": "Reed", "last_name": "Richards", "email": "mrfantastic@ff.org" },
          { "first_name": "Jessica", "last_name": "Jones", "email": "jewel@brooklyn.ny" }
        ]
      """


  Scenario: Search contacts matching first name and last name only
    Given the client sends a GET request to /contacts?search=Jone Rich
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly one contact
    And the JSON should contain:
      """
        [
          { "first_name": "Richard", "last_name": "Jones", "email": "abomb@smash.org" }
        ]
      """


  Scenario: Search contacts matching first name and state only
    Given the client sends a GET request to /contacts?search=Rich AZ
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly one contact
    And the JSON should contain:
      """
        [
          { "first_name": "Richard", "last_name": "Jones", "email": "abomb@smash.org", "state": "AZ" }
        ]
      """


  Scenario: Search contacts (matching first name and last name)
    Given the client sends a GET request to /contacts?search=Richard
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly two contacts
    And the JSON should contain:
      """
        [
          { "first_name": "Richard", "last_name": "Jones", "email": "abomb@smash.org" },
          { "first_name": "Reed", "last_name": "Richards", "email": "mrfantastic@ff.org" }
        ]
      """

  @wip
  # I don't see how this would work with a number field
  Scenario: Search contacts (matching zip and phone number)
    Given the client sends a GET request to /contacts?search=321
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly two contacts
    And the JSON should contain:
      """
        [
          { "first_name": "Richard", "last_name": "Jones", "email": "abomb@smash.org" },
          { "first_name": "Reed", "last_name": "Richards", "email": "mrfantastic@ff.org" }
        ]
      """
    

  Scenario: Search contacts resulting in no match
    Given the client sends a GET request to /contacts?search=mxyzptlk@5th.dimension
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly no contacts
