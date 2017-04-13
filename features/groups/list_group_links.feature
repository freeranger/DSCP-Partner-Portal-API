Feature: List Links for a Group
  In order to manage the Links for a Group
  I need to be able to list them.


  Background:
    Given the following user is registered:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |

    And the system knows about the following group:
      | id  | name         | description |
      | 123 | The Avengers | Earth's mightiest heroes |

    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: List group links (unauthenticated client)
    Given the client is not authenticated
    When the client sends a GET request to /groups/123/links
    Then a 401 status code is returned


  Scenario: List links for a non existing group
    Given the client sends a GET request to /groups/9999/links
    Then a 404 status code is returned


  Scenario: List group links where the group has no links
    Given the client sends a GET request to /groups/123/links
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly zero links


  Scenario: List group links where the group has links
    Given the system knows about the following links:
      | id  | title                  | destination              | group_id |
      | 456 | The Gamma Bomb Project | http://gammabombsrus.mil | 123      |
      | 789 | X-Men                  | http://xmen.com          | 123      |
    When the client sends a GET request to /groups/123/links
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly two links
    And the JSON should contain:
      """
        [
          { "title": "The Gamma Bomb Project", "destination": "http://gammabombsrus.mil",
             "_links": {
               "self" : { "href": "/groups/123/links/456" }
            }
          },
          { "title": "X-Men", "destination": "http://xmen.com",
             "_links": {
               "self" : { "href": "/groups/123/links/789" }
             }
           }
        ]
      """
