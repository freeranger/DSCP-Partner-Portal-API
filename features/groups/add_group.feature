Feature: Add Groups
  In order to group contacts together
  I need to be able to add a group.

  Background:
    Given the following user is registered:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |
    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: Add group (unauthenticated)
    Given the client is not authenticated
    When the client sends a POST request to /groups:
      """
          { "name": "Avengers", "description": "Earth's mightiest heroes" }
      """
    Then a 401 status code is returned


  Scenario: Add a group
    Given the client sends a POST request to /groups:
      """
          { "name": "The Avengers", "description": "Earth's mightiest heroes" }
      """
    Then a 201 status code is returned
    And the location header points to the created group
    And a group is created with:
      | name         | description |
      | The Avengers | Earth's mightiest heroes |


  Scenario: Add a group when one already exists with the same name
    Given the system knows about the following group:
      | name         | description              |
      | The Avengers | Earth's mightiest heroes |
    When the client sends a POST request to /groups:
      """
          { "name": "The Avengers", "description": "Not the JLA!" }
      """
    Then a 422 status code is returned
    And the response should be JSON
    And the JSON should contain:
      """
        { "name":["has already been taken"] }
      """


  Scenario: Add a group without a name
    Given the client sends a POST request to /groups:
      """
          { "description": "Super Friends" }
      """
    Then a 422 status code is returned
    And the response should be JSON
    And the JSON should contain:
      """
          {"name":["can't be blank"]}
      """

  Scenario: Add a group without a description
    Given the client sends a POST request to /groups:
      """
          { "name": "SHIELD" }
      """
    Then a 422 status code is returned
    And the response should be JSON
    And the JSON should contain:
      """
        {"description":["can't be blank"]}
      """
    