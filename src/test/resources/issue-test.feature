@newIssue
Feature: Validate new issue

  Background:
    * url 'https://gitlab.com/api/v4/projects/'
    * def token = 'glpat-TEFkYoiN5MpybMG1GaYq'

  Scenario: Create new issue, Update issue, GET issue and DELETE issue
    Given path '38809690/issues'
    And param title = "IssuewithClone"
    And param labels = "bug"
    And header PRIVATE-TOKEN = token
    And header Content-Type = 'application/json'
    When method POST
    Then status 201
    * def issueId = response.iid
    * def results = response
    * match results == read('issue-post-response.json')

    #Update issue
    Given path '38809690/issues/'+ issueId
    And param state_event = "close"
    And param confidential = true
    And param description = "Issue faced while cloning project using HTTPS"
    And param title = "Clone Issue"
    And param discussion_locked = false
    And param issue_type = "incident"
    And header PRIVATE-TOKEN = token
    And header Content-Type = 'application/json'
    When method PUT
    Then status 200
    * def results = response
    * match results == { "id": "#number", "iid": "#number", "project_id": 38809690, "title": "Clone Issue", "description": "Issue faced while cloning project using HTTPS", "state": "closed", "created_at": "#notnull", "updated_at": "#notnull", "closed_at": "#notnull", "closed_by": { "id": "#number", "username": "#string", "name": "#string", "state": "active", "avatar_url": "#string", "web_url": "#string" }, "labels": [ "bug" ], "milestone": null, "assignees": [], "author": { "id": "#number", "username": "#string", "name": "#string", "state": "active", "avatar_url": "#string", "web_url": "#string" }, "type": "INCIDENT", "assignee": null, "user_notes_count": "#number", "merge_requests_count": "#number", "upvotes": "#number", "downvotes": "#number", "due_date": null, "confidential": true, "discussion_locked": false, "issue_type": "incident", "web_url": "#string", "time_stats": { "time_estimate": "#number", "total_time_spent": "#number", "human_time_estimate": null, "human_total_time_spent": null }, "task_completion_status": { "count": "#number", "completed_count": "#number" }, "blocking_issues_count": "#number", "has_tasks": false, "_links": { "self": "#string", "notes": "#string", "award_emoji": "#string", "project": "#string", "closed_as_duplicate_of": null }, "references": { "short": "#string", "relative": "#string", "full": "#string" }, "severity": "UNKNOWN", "subscribed": true, "moved_to_id": null, "service_desk_reply_to": null }

    #GET issue
    Given path '38809690/issues'
    And header PRIVATE-TOKEN = token
    And header Content-Type = 'application/json'
    When method GET
    Then status 200
    And json responseJSON = response
    And match response[*].iid contains issueId
    #* def sorted_result = get responseJSON.response[*].iid
    #* def isFound = call read('sort.js') sorted_result

    #DELETE issue
    Given path '/38809690/issues/'+ issueId
    And header PRIVATE-TOKEN = token
    And header Content-Type = 'application/json'
    When method DELETE
    Then status 204

    #GET issue and verify new issue is deleted
    Given path '38809690/issues'
    And header PRIVATE-TOKEN = token
    And header Content-Type = 'application/json'
    When method GET
    Then status 200
    And match response[*].iid !contains issueId

