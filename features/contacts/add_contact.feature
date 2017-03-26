Feature: Add Contacts
  In order to manage contacts
  I need to be able to add them.

  Background:
    Given the system knows about the following user:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |

  Scenario: Add contact (unauthenticated client)
    When the client sends a POST request to /contacts:
      """
          { "first_name": "Bruce", "last_name": "Banner", "email": "hulk@smash.org" }
      """
    Then a 401 status code is returned

    
  Scenario: Add a contact (authenticated client)
    Given the client authenticates as x@westchester.ny
    When the client sends a POST request to /contacts:
      """
          { "first_name": "Bruce", "last_name": "Banner", "email": "hulk@smash.org" }
      """
    Then a 201 status code is returned
    And a contact is created with:
      | first_name       | last_name      | email               |
      | Bruce            | Banner         | hulk@smash.org      |

    
  Scenario: Add a contact when one already exists with the same email address
    Given the system knows about the following contacts:
      | first_name       | last_name      | email               |
      | Barry            | Allen          | flash@speedforce.io |
    And the client authenticates as x@westchester.ny
    When the client sends a POST request to /contacts:
      """
          { "first_name": "Wally", "last_name": "West", "email": "flash@speedforce.io" }
      """
    Then a 422 status code is returned

    Scenario: Add a contact with default values for city, and state
      Given the client authenticates as x@westchester.ny
      When the client sends a POST request to /contacts:
      """
          { "first_name": "Bruce", "last_name": "Banner", "email": "hulk@smash.org" }
      """
      Then a 201 status code is returned
      And a contact is created with:
        | email               |  city        | state |
        | hulk@smash.org      |  St. Charles | IL    |

      
  Scenario: Add a contact with specified values for city and state
    Given the client authenticates as x@westchester.ny
    When the client sends a POST request to /contacts:
      """
          { "first_name": "Diana", "last_name": "Prince", "email": "wonder@woman.io", "city": "Themyscira", "state": "Is" }
      """
    Then a 201 status code is returned
    And a contact is created with:
      | first_name       | last_name      | email               |  city        | state  |
      | Diana            | Prince         | wonder@woman.io     |  Themyscira  | Is     |
    