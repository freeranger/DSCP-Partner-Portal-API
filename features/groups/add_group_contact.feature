Feature: Add a Contact to a Group
  In order to manage the Contacts for a Group
  I need to be able to add contacts to groups.

  Background:
  Given the following user is registered:
    | first_name       | last_name      | email                       | password  |
    | Charles          | Xavier         | x@westchester.ny            | jeanrules |

    And the system knows about the following group:
    | id  | name         | description |
    | 123 | The Avengers | Earth's mightiest heroes |

    And the system knows about the following contact:
      | id  | first_name       | last_name      | email          | business_name | website       |
      | 456 | Bruce            | Banner         | hulk@smash.org | Hulks R Us    | www.smash.org |

    And the client authenticates as x@westchester.ny/jeanrules


  Scenario: Add contact to a group (unauthenticated)
    Given the client is not authenticated
    When the client sends a PUT request to /groups/123/contacts/456:
    """
    """
    Then a 401 status code is returned


  Scenario: Add a contact to a group that does not exist
    Given the client sends a PUT request to /groups/9999/contacts/456:
        """
        """
    Then a 404 status code is returned


  Scenario: Add a contact that does not exist to a group that does exist
    Given the client sends a PUT request to /groups/123/contacts/9999:
        """
        """
    Then a 404 status code is returned


  Scenario: Add a contact to a group
            No need to return a location header as we already know both the group and the contact
    Given the client sends a PUT request to /groups/123/contacts/456:
        """
        """
    Then a 201 status code is returned
    And the group contains contact id 456


  Scenario: Add a contact that already exists
            PUT is idempotent so this should "succeed" though the contact is not added a second time
    Given the group contains contact id 456
    When the client sends a PUT request to /groups/123/contacts/456:
        """
        """
    Then a 201 status code is returned
    And the group contains contact id 456 only once
    