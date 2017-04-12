Feature: Get a Link for a Group
  In order to manage the Links for a Group
  I need to be able to retrieve them.


  Background:
    Given the following user is registered:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |

    And the system knows about the following group:
      | id  | name         | description |
      | 123 | The Avengers | Earth's mightiest heroes |

    And the system knows about the following link:
      | id  | title                  | destination              | group_id |
      | 456 | The Gamma Bomb Project | http://gammabombsrus.mil | 123      |

    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: Get a group link (unauthenticated client)
    Given the client is not authenticated
    When the client sends a GET request to /groups/123/links/456
    Then a 401 status code is returned


  Scenario: Get a group link that exists
            Returns title, destiination, and a link to self
    Given the client sends a GET request to /groups/123/links/456
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should contain a single link
    And the JSON should contain:
      """
          { "title": "The Gamma Bomb Project",
            "destination": "http://gammabombsrus.mil",
              "_links": {
                "self": { "href": "/groups/123/links/456" }
              }
          }
      """
    

  Scenario: Get a group link for a non existing group
    Given the client sends a GET request to /groups/9999/links/456
    Then a 404 status code is returned


  Scenario: Get group link that does not exist
    Given the client sends a GET request to /groups/123/links/789
    Then a 404 status code is returned