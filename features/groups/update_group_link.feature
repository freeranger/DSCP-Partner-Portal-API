Feature: Update Links for a Group
  In order to manage the Links for a Group
  I need to be able to update existing links.

  Background:
    Given the following user is registered:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |
    And the system knows about the following group:
      | id  | name         | description |
      | 123 | The Avengers | Earth's mightiest heroes |

    And the system knows about the following link:
      | id  | title                  | destination              | group_id |
      | 456 | The Gammy Bomb Project | http://gammabombsrus.mil | 123      |

    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: Update an existing link (unauthenticated)
    Given the client is not authenticated
    When the client sends a PUT request to /groups/123/links/456:
      """
         { "title": "The Gamma Bomb Project", "destination": "http://gammabombsrus.mil" }
      """
    Then a 401 status code is returned


  Scenario: Update an existing link
    Given the client sends a PUT request to /groups/123/links/456:
      """
         { "title": "The Gamma Bomb Project", "destination": "http://gammabombsrus.mil" }
      """
    Then a 204 status code is returned
    And the link is updated with:
      | id  | title         | destination                        |
      | 456 | The Gamma Bomb Project | http://gammabombsrus.mil |


  Scenario: Update a non existing link
    Given the client sends a PUT request to /groups/123/links/9999:
      """
         { "title": "The Gamma Bomb Project", "destination": "http://gammabombsrus.mil" }
      """
    Then a 404 status code is returned


  Scenario: Update a link in a group that does not exist
    Given the client sends a PUT request to /groups/9999/links/456:
      """
         { "title": "The Gamma Bomb Project", "destination": "http://gammabombsrus.mil" }
      """
    Then a 404 status code is returned


  Scenario: Update an existing link with a title already in use
    Given the system knows about the following link:
      | id  | title                  | destination               | group_id |
      | 789 | The Other Bomb Project | http://gammabombsryou.mil | 123      |
    When the client sends a PUT request to /groups/123/links/789:
      """
         { "title": "The Gamma Bomb Project", "destination": "http://gammabombsrus.mil" }
      """
    Then a 204 status code is returned
    And the link is updated with:
      | id  | title         | destination                        |
      | 789 | The Gamma Bomb Project | http://gammabombsrus.mil |
    When the client sends a GET request to /groups/123/links
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
