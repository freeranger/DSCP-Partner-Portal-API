Feature: List Partners
  In order to find contacts who are partners
  I need to be able to get a list of them.

  Background:
    Given the following user is registered:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |

    And the system knows about the following contacts:
      | id | first_name       | last_name      | email                     | business_name          | website      | partner |
      | 1  | Warren           | Worthington    | angel@w3.org              | Worthington Industries | www.wi.com   | true    |
      | 2  | Jessica          | Jones          | jewel@brooklyn.ny         | Alias Investigations   | www.jj.com   | false   |
      | 3  | Jean             | Grey           | jean@grey.me              | Uncanny X-Men R Us     | www.x.org    | true    |

    And the client authenticates as x@westchester.ny/jeanrules

  Scenario: List partners (unauthenticated)
    Given the client is not authenticated
    When the client sends a GET request to /partners
    Then a 401 status code is returned


  Scenario: List partners
    Returns first_name, last_name, email, business_name and self links only
    Given the client sends a GET request to /partners
    Then a 200 status code is returned
    And the response should be JSON
    And the JSON should contain:
      """
        [
          { 
            "first_name": "Warren", 
            "last_name": "Worthington", 
            "email": "angel@w3.org", 
            "business_name": "Worthington Industries",
            "website": "www.wi.com",
            "partner": true,
            "_links": {
              "self" : { "href": "/contacts/1" }
            }
          },
          { 
            "first_name": "Jean", 
            "last_name": "Grey", 
            "email": "jean@grey.me", 
            "business_name": "Uncanny X-Men R Us",
            "website": "www.x.org",
            "partner": true,
            "_links": {
              "self" : { "href": "/contacts/3" }
            }
          }
        ]
      """
    And the JSON should not contain:
      """
          { 
            "first_name": "Jessica", 
            "last_name": "Jones", 
            "email": "jewel@brooklyn.ny",
            "website": "www.jj.com",
            "partner": false,
            "_links": {
              "self" : { "href": "/contacts/2" }
            }
          }
      """