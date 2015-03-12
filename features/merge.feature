Feature: Merge Article
  As a blog administrator
  In order to minimize redundant articles
  I want to merge similar articles

  Background:

    Given the following articles exist:

    | title | author | body          |
    | art1  | John   | what a baller |
    | art2  | Rafi   | hes a stud   |
    | art3  | Daxi   | lol           |

    And the blog is set up

  Scenario: Admin sees merge functionality
    Given I am logged into the admin panel 
    And I am on the Edit page for "art1"
    Then I should see "Merge Articles"

  Scenario: Non-admin should not see merge functionality
    Given I am not an admin
    And I on the Edit page for "art1"
    Then I should not see 'Merge Articles'

  Scenario: When articles are merged, the merged article should contain the text of both previous articles.
    Given I have merged "art1" and "art2"
    And I am on the Show page for "art1"
    Then I should see "what a baller"
    And I should see "hes a stud"

  Scenario: When articles are merged, the merged article should have one author (either one of the authors of the original article).  
    Given I have merged "art1" and "art2"
    And I am on the "All Articles" page
    Then the author for "art1" should be "John"
    And I should not see "Rafi"

  Scenario: Comments on each of the two original articles need to all carry over and point to the new, merged article.
    Given "weirdo" is a comment for "art1"
    And "bigger weirdo" is a comment for "art2"
    Given I have merged "art1" and "art2"
    When I am on the Show page for "art1"
    Then I should see "weirdo"
    And I should see "bigger weirdo"

  Scenario: The title of the new article should be the title from either one of the merged articles.
    Given I have merged "art1" and "art2"
    And I am on the "All Articles" page
    Then the title for "art1" should be "art1"
    And I should not see "art2"