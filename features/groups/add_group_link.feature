Feature: Add a Link to a Group
  In order to manage the Links for a Group
  I need to be able to add new links.

  Background:
    Given the following user is registered:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |
    And the system knows about the following group:
      | id  | name         | description |
      | 123 | The Avengers | Earth's mightiest heroes |
    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: Add link (unauthenticated)
    Given the client is not authenticated
    When the client sends a POST request to /groups/123/links:
      """
         { "title": "The Gamma Bomb Project", "destination": "http://gammabombsrus.mil" }
      """
    Then a 401 status code is returned


  Scenario: Add a link to a group that does not exist
    Given the client sends a POST request to /groups/9999/links:
      """
         { "title": "The Gamma Bomb Project", "destination": "http://gammabombsrus.mil" }
      """
    Then a 404 status code is returned
    

  Scenario: Add a link
    Given the client sends a POST request to /groups/123/links:
      """
         { "title": "The Gamma Bomb Project", "destination": "http://gammabombsrus.mil" }
      """
    Then a 201 status code is returned
    And the location header points to the created link
    And the link is created with:
      | title                  | destination              |
      | The Gamma Bomb Project | http://gammabombsrus.mil |


  Scenario: Add a link when one already exists with the same name
            The duplicate link is added
    Given the system knows about the following link:
      | id  | title                  | destination              | group_id |
      | 456 | The Gamma Bomb Project | http://gammabombsrus.mil | 123      |
    When the client sends a POST request to /groups/123/links:
      """
         { "title": "The Gamma Bomb Project", "destination": "http://gammabombsrus.mil" }
      """
    Then a 201 status code is returned
    And the location header points to the created link
    And the link is created with:
      | title                  | destination              |
      | The Gamma Bomb Project | http://gammabombsrus.mil |
    And the client sends a GET request to /groups/123/links
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly two links
    And the JSON should contain:
      """
        [
          { "title": "The Gamma Bomb Project", "destination": "http://gammabombsrus.mil" },
          { "title": "The Gamma Bomb Project", "destination": "http://gammabombsrus.mil" }
        ]
      """


  Scenario: Add a link without a title
    Given the client sends a POST request to /groups/123/links:
      """
         { "destination": "http://gammabombsrus.mil" }
      """
    Then a 422 status code is returned
    And the response should be JSON
    And the JSON should contain:
      """
          {"title":["can't be blank", "is too short (minimum is 2 characters)"]}
      """

  Scenario: Add a link without a destination
    Given the client sends a POST request to /groups/123/links:
      """
         { "title": "The Gamma Bomb Project" }
      """
    Then a 422 status code is returned
    And the response should be JSON
    And the JSON should contain:
      """
        {"destination":["can't be blank", "is too short (minimum is 12 characters)", "is not a valid URL"]}
      """


  Scenario: Add a link with a destination that is not a valid URL
    Given the client sends a POST request to /groups/123/links:
      """
          { "title": "The Gamma Bomb Project", "destination": "this is not a URL" }
      """
    Then a 422 status code is returned
    And the response should be JSON
    And the JSON should contain:
      """
        {"destination":["is not a valid URL"]}
      """
