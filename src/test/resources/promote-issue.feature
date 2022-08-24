@promoteIssue
Feature: Promote an issue to an epic

  Background:
    * url baseUrl
    * def token = token

  Scenario: Promotes an issue to an epic by adding a comment with the word promote

    #Create an issue
    Given path 'issues'
    And param title = "IssuewithClone"
    And param labels = "bug"
    And header PRIVATE-TOKEN = token
    And header Content-Type = 'application/json'
    When method POST
    Then status 201
    * def issueId = response.iid
    * def results = response
    * match results == read('issue-post-response.json')

    #Promotes an issue
    Given path 'issues/'+ issueId +'/notes'
    And param body = "Lets promote this to an epic"
    And header PRIVATE-TOKEN = token
    And header Content-Type = 'application/json'
    When method POST
    Then status 201
    * def results = response
    * match results == read('promoteIssue-response.json')
