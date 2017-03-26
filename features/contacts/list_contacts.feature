Feature: List Contacts
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


  Scenario: List contacts (unauthenticated client)
    When the client sends a GET request to /contacts
    Then a 401 status code is returned


  Scenario: List contacts (authenticated client)
    Given the client authenticates as x@westchester.ny
    When the client sends a GET request to /contacts
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have at least two contacts
    # This style is format-agnostic, though in reality, JSON will be the format of choice
    # But I thought I would put out both - this can have value if you only want specific attributes
    # rather than being interested in the shape of the JSON itself
    And one contact has the following attributes:
      | attribute     | type   | value                      |
      | first_name    | String | Jessica                    |
      | last_name     | String | Jones                      |
      | email         | String | jewel@brooklyn.ny          |
    # For example:
    And at least two contacts have the following attributes:
      | attribute  | type   | value  |
      | state | String | IL |
    # I prefer the format below because the client developer can see what a response should look like.
    # Note that this will check the result contains these values, not tha the actual entity is exactly that
    And the JSON should contain:
      """
        [
          { "first_name": "Reed", "last_name": "Richards", "email": "mrfantastic@ff.com" },
          { "first_name": "Jessica", "last_name": "Jones", "email": "jewel@brooklyn.ny" }
        ]
      """
    # This is checking the entire entity matches the result
    # Note that created and updated dates are excluded from the entities - these are really for internal purposes so not sure of the value of exposing them
    And the JSON should contain exactly:
      """
          { "id": 2, "first_name": "Jessica", "last_name": "Jones", "email": "jewel@brooklyn.ny", "city": "St. Charles", "state": "IL", "partner": false }
      """

  