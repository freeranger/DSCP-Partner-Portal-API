Feature: Add Contacts (authenticated client)
  In order to manage contacts
  I need to be able to add them.

  Background:
    Given the system knows about the following user:
      | first_name       | last_name      | email                       | password  |
      | Charles          | Xavier         | x@westchester.ny            | jeanrules |
    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: Add contact (unauthenticated)
    Given the client is not authenticated
    When the client sends a POST request to /contacts:
      """
          { "first_name": "Bruce", "last_name": "Banner", "email": "hulk@smash.org" }
      """
    Then a 401 status code is returned

    
  Scenario: Add a contact
    Given the client sends a POST request to /contacts:
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
    When the client sends a POST request to /contacts:
      """
          { "first_name": "Wally", "last_name": "West", "email": "flash@speedforce.io" }
      """
    Then a 422 status code is returned
    And the response should be JSON
    And the JSON should contain:
      """
        { "email":["has already been taken"] }
      """

    
    Scenario: Add a contact without a first_name
      Given the client sends a POST request to /contacts:
      """
          { "last_name": "Banner", "email": "hulk@smash.org" }
      """
      Then a 422 status code is returned
      And the response should be JSON
      And the JSON should contain:
      """
          {"first_name":["can't be blank", "is invalid", "is too short (minimum is 2 characters)"]}
      """

  Scenario: Add a contact without a last_name
    Given the client sends a POST request to /contacts:
      """
          { "first_name": "Bruce", "email": "hulk@smash.org" }
      """
    Then a 422 status code is returned
    And the response should be JSON
    And the JSON should contain:
      """
        {"last_name":["can't be blank", "is invalid", "is too short (minimum is 2 characters)"]}
      """


  Scenario: Add a contact without an email address
    Given the client sends a POST request to /contacts:
      """
          { "first_name": "Bruce", "last_name": "Banner" }
      """
    Then a 422 status code is returned
    And the response should be JSON
    And the JSON should contain:
      """
          { "email":["can't be blank", "is invalid"] }
    """


  Scenario: Add a contact with an invalid email address
    Given the client sends a POST request to /contacts:
      """
          { "first_name": "Bruce", "last_name": "Banner", "email": "xxinvalidxx" }
      """
    Then a 422 status code is returned
    And the response should be JSON
    And the JSON should contain:
      """
          {"email":["is invalid"]}
      """


    Scenario: Adding a contact without city and state populates default values for these fields
      Given the client sends a POST request to /contacts:
      """
          { "first_name": "Bruce", "last_name": "Banner", "email": "hulk@smash.org" }
      """
      Then a 201 status code is returned
      And a contact is created with:
        | email               |  city        | state |
        | hulk@smash.org      |  St. Charles | IL    |

      
  Scenario: Add a contact with specified values for city and state
    Given the client sends a POST request to /contacts:
      """
          { "first_name": "Diana", "last_name": "Prince", "email": "wonder@woman.io", "city": "Themyscira", "state": "Is" }
      """
    Then a 201 status code is returned
    And a contact is created with:
      | first_name       | last_name      | email               |  city        | state  |
      | Diana            | Prince         | wonder@woman.io     |  Themyscira  | Is     |
    