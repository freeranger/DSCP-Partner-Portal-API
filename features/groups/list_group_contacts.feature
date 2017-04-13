Feature: List Contacts for a Group
  In order to manage the Contacts for a Group
  I need to be able to list them.


  Background:
    Given the following user is registered:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |

    And the system knows about the following group:
      | id  | name         | description |
      | 123 | The Avengers | Earth's mightiest heroes |

    And the system knows about the following contacts:
      | id  | first_name       | last_name      | email               | business_name        | website       |
      | 456 | Reed             | Richards       | mrfantastic@ff.com  | FF, Inc              | www.ff.us     |
      | 789 | Jessica          | Jones          | jewel@brooklyn.ny   | Alias Investigations | www.jj.com    |
      | 987 | Barry            | Allen          | flash@speedforce.io | Star Labs            | www.flash.org |

    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: List group contacts (unauthenticated client)
    Given the client is not authenticated
    When the client sends a GET request to /groups/123/contacts
    Then a 401 status code is returned


  Scenario: List contacts for a non existing group
    Given the client sends a GET request to /groups/9999/contacts
    Then a 404 status code is returned


  Scenario: List group contacts where the group has no contacts
    Given the client sends a GET request to /groups/123/contacts
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly zero contacts


  Scenario: List group contacts where the group has contacts
    Returns first_name, last_name, email, business_name and self links only
    And the system knows about the following group contacts:
      | group_id  | contact_id |
      | 123       | 456        |
      | 123       | 789        |
    When the client sends a GET request to /groups/123/contacts
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have exactly two contacts
    And the JSON should contain:
      """
        [
          { "first_name": "Reed", "last_name": "Richards", "email": "mrfantastic@ff.com", "business_name": "FF, Inc",
            "_links": {
              "self" : { "href": "/contacts/456" }
            }
          },
          { "first_name": "Jessica", "last_name": "Jones", "email": "jewel@brooklyn.ny", "business_name": "Alias Investigations",
            "_links": {
              "self" : { "href": "/contacts/789" }
            }
          }
        ]
       """
    And the JSON should not contain:
      """
          { "first_name": "Barry", "last_name": "Allen", "email": "flash@speedforce.io" }
      """
    And the JSON should not contain:
    """
       {"website": "www.ff.us"}

    """
    And the JSON should not contain:
    """
      {"website": "www.jj.com"}
    """

