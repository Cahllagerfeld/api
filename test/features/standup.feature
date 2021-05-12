Feature: Standup-module

    Scenario: add a new standup
        Given authorisation
        And make a POST request to "/standup" with:
            | discordUser      | "eddiehubber"          |
            | yesterdayMessage | "Yesterday I did this" |
            | todayMessage     | "Today I'll do this"   |
        Then the response status code should be 201
        And the response should contain:
            | documentId | "TYPE:ID" |

    Scenario: search existing standup
        Given authorisation
        And make a POST request to "/standup" with:
            | discordUser      | "eddiehubber"          |
            | yesterdayMessage | "Yesterday I did this" |
            | todayMessage     | "Today I'll do this"   |
        Then the response should contain:
            | documentId | "TYPE:ID" |
        Then  make a GET request to "/standup/search?discordUser=eddiehubber"
        Then the response status code should be 200
        And the response in item where field "discordUser" is equal to "eddiehubber" should contain:
            | discordUser      | "TYPE:STRING" |
            | todayMessage     | "TYPE:STRING" |
            | yesterdayMessage | "TYPE:STRING" |
            | createdOn        | "TYPE:DATE"   |

    Scenario: search non-existing standup
        Given authorisation
        And make a POST request to "/standup" with:
            | discordUser      | "eddiehubber"          |
            | yesterdayMessage | "Yesterday I did this" |
            | todayMessage     | "Today I'll do this"   |
        Then the response should contain:
            | documentId | "TYPE:ID" |
        Then  make a GET request to "/standup/search?discordUser=hubber"
        Then the response status code should be 200
        And  the response should be "{}"

    Scenario: provide no search context
        Given authorisation
        And make a POST request to "/standup" with:
            | discordUser      | "eddiehubber"          |
            | yesterdayMessage | "Yesterday I did this" |
            | todayMessage     | "Today I'll do this"   |
        Then the response should contain:
            | documentId | "TYPE:ID" |
        Then  make a GET request to "/standup/search"
        Then the response status code should be 400
        And  the response should contain:
            | statusCode | "TYPE:NUMBER" |
            | message    | "TYPE:STRING" |

    Scenario: add an empty standup
        Given authorisation
        And make a POST request to "/standup" with:
            | test | "test" |
        Then the response status code should be 400
        And the response should contain:
            | statusCode | "TYPE:NUMBER" |
            | error      | "TYPE:STRING" |
        And the response property "message" has items:
            | discordUser should not be empty      |
            | discordUser must be a string         |
            | yesterdayMessage should not be empty |
            | yesterdayMessage must be a string    |
            | todayMessage should not be empty     |
            | todayMessage must be a string        |

    Scenario: delete standup
        Given authorisation
        And make a POST request to "/standup" with:
            | discordUser      | "eddiehubber"          |
            | yesterdayMessage | "Yesterday I did this" |
            | todayMessage     | "Today I'll do this"   |
        Then the response should contain:
            | documentId | "TYPE:ID" |
        Then make a DELETE request to "/standup/{id}"
        Then the response status code should be 204

    Scenario: delete non-existent standup
        Given authorisation
        And make a POST request to "/standup" with:
            | discordUser      | "eddiehubber"          |
            | yesterdayMessage | "Yesterday I did this" |
            | todayMessage     | "Today I'll do this"   |
        Then the response should contain:
            | documentId | "TYPE:ID" |
        Then make a DELETE request to "/standup/66"
        Then the response status code should be 404
        And  the response should contain:
            | statusCode | "TYPE:NUMBER" |
            | message    | "TYPE:STRING" |

    Scenario: get standup with authenticated request
        Given authorisation
        And make a POST request to "/standup" with:
            | discordUser      | "eddiehubber"          |
            | yesterdayMessage | "Yesterday I did this" |
            | todayMessage     | "Today I'll do this"   |
        Then the response should contain:
            | documentId | "TYPE:ID" |
        When make a GET request to "/standup/{id}"
        Then the response status code should be 200
        And the response should contain:
            | discordUser      | "TYPE:STRING" |
            | todayMessage     | "TYPE:STRING" |
            | yesterdayMessage | "TYPE:STRING" |
            | createdOn        | "TYPE:DATE"   |

    Scenario: create standup without authorization
        Given make a POST request to "/standup" with:
            | discordUser      | "eddiehubber"          |
            | yesterdayMessage | "Yesterday I did this" |
            | todayMessage     | "Today I'll do this"   |
        Then the response status code should be 401
        And the response should contain:
            | statusCode | "TYPE:NUMBER" |
            | message    | "TYPE:STRING" |
