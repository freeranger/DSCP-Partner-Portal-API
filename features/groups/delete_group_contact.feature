Feature: Remove a Contact from a Group
  In order to manage the Contacts in a Group
  I need to be able to remove contacts from a group.

  Background:
    Given the following user is registered:
      | id | first_name       | last_name      | email                       | password  |
      | 1  |Charles          | Xavier          | x@westchester.ny            | jeanrules |

    And the system knows about the following group:
      | id  | name         | description |
      | 123 | The Avengers | Earth's mightiest heroes |

    And the system knows about the following contacts:
      | id  | first_name       | last_name      | email             |
      | 456 | Bruce            | Banner         | hulk@smash.org    |
      | 789 | Jessica          | Jones          | jewel@brooklyn.ny |

    And the system knows about the following group contacts:
      | group_id  | contact_id |
      | 123       | 456        |

    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: Delete a group contact (unauthenticated client)
    Given the client is not authenticated
    When the client sends a DELETE request to /groups/123/contacts/456
    Then a 401 status code is returned


  Scenario: Delete an existing contact
    Given the client sends a DELETE request to /groups/123/contacts/456
    Then a 204 status code is returned
    And the group does not contain contact id 456
    And the contact id 456 still exists


  Scenario: Delete a group contact where the contact does not exist
    Given the client sends a DELETE request to /groups/123/contacts/9999
    Then a 404 status code is returned


  Scenario: Delete a group contact where the group does not exist
    Given the client sends a DELETE request to /groups/9999/contacts/456
    Then a 404 status code is returned


  Scenario: Delete a group contact where the contact is not in the group
    Given the client sends a DELETE request to /groups/123/contacts/789
    Then a 204 status code is returned
