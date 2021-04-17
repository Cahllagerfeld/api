Feature: github-module

    Scenario: get list of githubprofiles
        Given make a GET request to "/standup"
        Then the response status code should be 200
        And the response should be "[]"

    Scenario: add a new githubprofile
        Given make a POST request to "/github" with:
            | username       | "eddiehubber"              |
            | bio            | "I love to code"           |
            | avatarUrl      | "https://dummy.com/avatar" |
            | followers      | 500                        |
            | repos          | 32                         |
            | communityStats | {"property":"value"}       |
        Then the response status code should be 201
        And the response should contains:
            | id             | 123                        |
            | username       | "eddiehubber"              |
            | bio            | "I love to code"           |
            | avatarUrl      | "https://dummy.com/avatar" |
            | followers      | 500                        |
            | repos          | 32                         |
            | communityStats | {"property":"value"}       |
            | updatedOn      | "2021-01-01T00:00:00.000Z" |
            | createdOn      | "2021-01-01T00:00:00.000Z" |

    Scenario: add an empty githubprofile
        Given make a POST request to "/github" with:
            | test | "test" |
        Then the response status code should be 400
        And the response should contains:
            | statusCode | 400               |
            | message    | "Incomplete Data" |

    Scenario: delete a githubprofile
        Given make a POST request to "/github" with:
            | username       | "eddiehubber"              |
            | bio            | "I love to code"           |
            | avatarUrl      | "https://dummy.com/avatar" |
            | followers      | 500                        |
            | repos          | 32                         |
            | communityStats | {"property":"value"}       |
        Then make a DELETE request to "/github/123"
        Then the response status code should be 200
        And the response should be "{}"

    Scenario: delete non-existent githubprofile
        Given make a POST request to "/github" with:
            | username       | "eddiehubber"              |
            | bio            | "I love to code"           |
            | avatarUrl      | "https://dummy.com/avatar" |
            | followers      | 500                        |
            | repos          | 32                         |
            | communityStats | {"property":"value"}       |
        Then make a DELETE request to "/github/66"
        Then the response status code should be 404
        And the response should contains:
            | statusCode | 404                       |
            | message    | "Githubprofile Not Found" |
