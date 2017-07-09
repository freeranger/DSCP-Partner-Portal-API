Feature: List Contacts
  In order to manage contacts
  I need to be able to list them.

  Background:
    Given the following user is registered:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |

    And the system knows about the following contacts:
      | id  | first_name       | last_name      | email                     | business_name        | website    | partner |
      | 123 | Reed             | Richards       | mrfantastic@ff.com        | FF, Inc              | www.ff.us  | true |
      | 456 | Jessica          | Jones          | jewel@brooklyn.ny         | Alias Investigations | www.jj.com | false |

    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: List contacts (unauthenticated client)
    Given the client is not authenticated
    When the client sends a GET request to /contacts
    Then a 401 status code is returned


  Scenario: List contacts
            Returns first_name, last_name, email, business_name and self links only
    Given the client sends a GET request to /contacts
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should have at least two contacts
    And the JSON should contain:
      """
        [
          { 
            "first_name": "Reed", 
            "last_name": "Richards", 
            "email": "mrfantastic@ff.com", 
            "business_name": "FF, Inc",
            "website": "www.ff.us",
            "partner": true,
            "_links": {
              "self" : { "href": "/contacts/123" }
            }
          },
          { 
            "first_name": "Jessica", 
            "last_name": "Jones", 
            "email": "jewel@brooklyn.ny", 
            "business_name": "Alias Investigations",
            "website": "www.jj.com",
            "partner": false,
            "_links": {
              "self" : { "href": "/contacts/456" }
            }
          }
        ]
      """

  