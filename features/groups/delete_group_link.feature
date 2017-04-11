Feature: Delete Links for a Group
  In order to manage the Links for a Group
  I need to be able to delete existing links.

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


  Scenario: Delete a link (unauthenticated client)
    Given the client is not authenticated
    When the client sends a DELETE request to /groups/123/links/456
    Then a 401 status code is returned


  Scenario: Delete an existing link
    Given the client sends a DELETE request to /groups/123/links/456
    Then a 204 status code is returned
    And the link id 456 does not exist


  Scenario: Delete an non existing link
    Given the client sends a DELETE request to /groups/123/links/9999
    Then a 404 status code is returned
