@timeEstimate
Feature: Set a time estimate for an issue

  Background:
   #* url 'https://gitlab.com/api/v4/projects/'
    * url baseUrl
    * def token = token

  Scenario: Sets an estimated time, reset the estimated time, Add spent time, Resets the total spent time and Get time tracking stats

    #Create issue
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

    #Sets an estimated time
    Given path 'issues/'+ issueId +'/time_estimate'
    And param duration = "3h30m"
    And header PRIVATE-TOKEN = token
    And header Content-Type = 'application/json'
    When method POST
    Then status 200
    * def results = response
    * match results == {"time_estimate":12600,"total_time_spent":0,"human_time_estimate":"3h 30m","human_total_time_spent":null}

    #Reset the estimated time
    Given path 'issues/'+ issueId +'/reset_time_estimate'
    And header PRIVATE-TOKEN = token
    And header Content-Type = 'application/json'
    When method POST
    Then status 200
    * def results = response
    * match results == {"time_estimate":0,"total_time_spent":0,"human_time_estimate":null,"human_total_time_spent":null}

    #Add spent time
    Given path 'issues/'+ issueId +'/add_spent_time'
    And param duration = "1h"
    And header PRIVATE-TOKEN = token
    And header Content-Type = 'application/json'
    When method POST
    Then status 201
    * def results = response
    * match results == {"time_estimate":0,"total_time_spent":3600,"human_time_estimate":null,"human_total_time_spent":"1h"}

    #Resets the total spent time
    Given path 'issues/'+ issueId +'/reset_spent_time'
    And header PRIVATE-TOKEN = token
    And header Content-Type = 'application/json'
    When method POST
    Then status 200
    * def results = response
    * match results == {"time_estimate":0,"total_time_spent":0,"human_time_estimate":null,"human_total_time_spent":null}

    #Get time tracking stats
    Given path 'issues/'+ issueId +'/time_stats'
    And header PRIVATE-TOKEN = token
    And header Content-Type = 'application/json'
    When method GET
    Then status 200
    * def results = response
    * match results == {"time_estimate":0,"total_time_spent":0,"human_time_estimate":null,"human_total_time_spent":null}