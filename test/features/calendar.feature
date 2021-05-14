# Feature: calendar module

#     Scenario: get list of events
#         Given make a GET request to "/calendar"
#         Then the response status code should be 200
#         And the response should contain:
#             | future  | [] |
#             | ongoing | [] |

#     Scenario: add a new user
#         Given authorisation
#         And make a POST request to "/calendar" with:
#             | name        | "Livestream XY"                       |
#             | description | "descriptive Description"             |
#             | url         | "https://domain.com"                  |
#             | platform    | "YouTube"                             |
#             | author      | {"platform":"discord","uid":"hubber"} |
#             | startDate   | "2021-01-01T00:00:00.000Z"            |
#             | endDate     | "2021-01-01T00:00:00.000Z"            |

#         Then the response status code should be 201
#         And the response should contain:
#             | id          | 123                                   |
#             | name        | "Livestream XY"                       |
#             | description | "descriptive Description"             |
#             | url         | "https://domain.com"                  |
#             | platform    | "YouTube"                             |
#             | author      | {"platform":"discord","uid":"hubber"} |
#             | startDate   | "2021-01-01T00:00:00.000Z"            |
#             | endDate     | "2021-01-01T00:00:00.000Z"            |
#             | createdOn   | "2021-01-01T00:00:00.000Z"            |
#             | updatedOn   | "2021-01-01T00:00:00.000Z"            |

#     Scenario: add an empty event
#         Given authorisation
#         And make a POST request to "/calendar" with:
#             | test | "test" |
#         Then the response status code should be 400
#         And the response should contain:
#             | statusCode | 400           |
#             | error      | "Bad Request" |
#         And the response property "message" has items:
#             | name must be a string                                         |
#             | name should not be empty                                      |
#             | platform must be one of the following values: YouTube, Twitch |
#             | platform must be a string                                     |
#             | platform should not be empty                                  |
#             | author should not be empty                                    |
#             | startDate should not be empty                                 |
#             | startDate must be a Date instance                             |
#             | endDate must be a Date instance                               |
#             | endDate should not be empty                                   |

#     Scenario: update an event
#         Given authorisation
#         And make a POST request to "/calendar" with:
#             | name        | "Livestream XY"                       |
#             | description | "descriptive Description"             |
#             | url         | "https://domain.com"                  |
#             | platform    | "YouTube"                             |
#             | author      | {"platform":"discord","uid":"hubber"} |
#             | startDate   | "2021-01-01T00:00:00.000Z"            |
#             | endDate     | "2021-01-01T00:00:00.000Z"            |
#         When make a PUT request to "/calendar/123" with:
#             | name        | "Livestream YZ"                      |
#             | description | "undescriptive Description"          |
#             | url         | "https://mydomain.com"               |
#             | platform    | "Twitch"                             |
#             | author      | {"platform":"discord","uid":"hubby"} |
#             | startDate   | "2021-01-01T00:00:00.000Z"           |
#             | endDate     | "2021-01-01T00:00:00.000Z"           |
#         Then the response status code should be 200
#         And the response should contain:
#             | id          | 123                                  |
#             | name        | "Livestream YZ"                      |
#             | description | "undescriptive Description"          |
#             | url         | "https://mydomain.com"               |
#             | platform    | "Twitch"                             |
#             | author      | {"platform":"discord","uid":"hubby"} |
#             | startDate   | "2021-01-01T00:00:00.000Z"           |
#             | endDate     | "2021-01-01T00:00:00.000Z"           |
#             | createdOn   | "2021-01-01T00:00:00.000Z"           |
#             | updatedOn   | "2021-01-01T00:00:00.000Z"           |

#     Scenario: update an non-existing event
#         Given authorisation
#         And make a POST request to "/calendar" with:
#             | name        | "Livestream XY"                       |
#             | description | "descriptive Description"             |
#             | url         | "https://domain.com"                  |
#             | platform    | "YouTube"                             |
#             | author      | {"platform":"discord","uid":"hubber"} |
#             | startDate   | "2021-01-01T00:00:00.000Z"            |
#             | endDate     | "2021-01-01T00:00:00.000Z"            |
#         When make a PUT request to "/calendar/321" with:
#             | name        | "Livestream YZ"                      |
#             | description | "undescriptive Description"          |
#             | url         | "https://mydomain.com"               |
#             | platform    | "Twitch"                             |
#             | author      | {"platform":"discord","uid":"hubby"} |
#             | startDate   | "2021-01-01T00:00:00.000Z"           |
#             | endDate     | "2021-01-01T00:00:00.000Z"           |
#         Then the response status code should be 404
#         And the response should contain:
#             | message    | "Event Not Found" |
#             | statusCode | 404               |

#     Scenario: delete an event
#         Given authorisation
#         And make a POST request to "/calendar" with:
#             | name        | "Livestream XY"                       |
#             | description | "descriptive Description"             |
#             | url         | "https://domain.com"                  |
#             | platform    | "YouTube"                             |
#             | author      | {"platform":"discord","uid":"hubber"} |
#             | startDate   | "2021-01-01T00:00:00.000Z"            |
#             | endDate     | "2021-01-01T00:00:00.000Z"            |
#         When make a DELETE request to "/calendar/123"
#         Then the response status code should be 200
#         And the response should be "{}"

#     Scenario: delete non-existing event
#         Given authorisation
#         And make a POST request to "/calendar" with:
#             | name        | "Livestream XY"                       |
#             | description | "descriptive Description"             |
#             | url         | "https://domain.com"                  |
#             | platform    | "YouTube"                             |
#             | author      | {"platform":"discord","uid":"hubber"} |
#             | startDate   | "2021-01-01T00:00:00.000Z"            |
#             | endDate     | "2021-01-01T00:00:00.000Z"            |
#         When make a DELETE request to "/calendar/321"
#         Then the response status code should be 404
#         And the response should contain:
#             | statusCode | 404               |
#             | message    | "Event Not Found" |

#     Scenario: get events with authenticated request
#         Given authorisation
#         And make a POST request to "/calendar" with:
#             | name        | "Livestream XY"                       |
#             | description | "descriptive Description"             |
#             | url         | "https://domain.com"                  |
#             | platform    | "YouTube"                             |
#             | author      | {"platform":"discord","uid":"hubber"} |
#             | startDate   | "2021-01-01T00:00:00.000Z"            |
#             | endDate     | "2021-01-01T00:00:00.000Z"            |
#         When make a GET request to "/calendar/123"
#         Then the response status code should be 200
#         And the response should contain:
#             | id          | 123                                   |
#             | name        | "Livestream XY"                       |
#             | description | "descriptive Description"             |
#             | url         | "https://domain.com"                  |
#             | platform    | "YouTube"                             |
#             | author      | {"platform":"discord","uid":"hubber"} |
#             | startDate   | "2021-01-01T00:00:00.000Z"            |
#             | endDate     | "2021-01-01T00:00:00.000Z"            |
#             | createdOn   | "2021-01-01T00:00:00.000Z"            |
#             | updatedOn   | "2021-01-01T00:00:00.000Z"            |

#     Scenario: create a event without authorization
#         Given make a POST request to "/calendar" with:
#             | name        | "Livestream XY"                       |
#             | description | "descriptive Description"             |
#             | url         | "https://domain.com"                  |
#             | platform    | "YouTube"                             |
#             | author      | {"platform":"discord","uid":"hubber"} |
#             | startDate   | "2021-01-01T00:00:00.000Z"            |
#             | endDate     | "2021-01-01T00:00:00.000Z"            |
#         Then the response status code should be 401
#         And the response should contain:
#             | statusCode | 401            |
#             | message    | "Unauthorized" |

#     Scenario: get sorted ongoing and future events
#         Given authorisation
#         And make a POST request to "/calendar" with:
#             | name        | "Livestream XY"                       |
#             | description | "descriptive Description"             |
#             | url         | "https://domain.com"                  |
#             | platform    | "YouTube"                             |
#             | author      | {"platform":"discord","uid":"hubber"} |
#             | startDate   | "2022-01-01T00:00:00.000Z"            |
#             | endDate     | "2023-01-01T00:00:00.000Z"            |
#         When make a POST request to "/calendar" with:
#             | name        | "Livestream YZ"                      |
#             | description | "undescriptive Description"          |
#             | url         | "https://mydomain.com"               |
#             | platform    | "Twitch"                             |
#             | author      | {"platform":"discord","uid":"hubby"} |
#             | startDate   | "2021-01-01T00:00:00.000Z"           |
#             | endDate     | "2022-01-01T00:00:00.000Z"           |
#         When make a GET request to "/calendar"
#         Then the response status code should be 200
#         And the response in property "future" and item "0" should contain:
#             | id          | 123                                   |
#             | name        | "Livestream XY"                       |
#             | description | "descriptive Description"             |
#             | url         | "https://domain.com"                  |
#             | platform    | "YouTube"                             |
#             | author      | {"platform":"discord","uid":"hubber"} |
#             | startDate   | "2022-01-01T00:00:00.000Z"            |
#             | endDate     | "2023-01-01T00:00:00.000Z"            |
#             | createdOn   | "2021-01-01T00:00:00.000Z"            |
#             | updatedOn   | "2021-01-01T00:00:00.000Z"            |
#         And the response in property "ongoing" and item "0" should contain:
#             | id          | 123                                  |
#             | name        | "Livestream YZ"                      |
#             | description | "undescriptive Description"          |
#             | url         | "https://mydomain.com"               |
#             | platform    | "Twitch"                             |
#             | author      | {"platform":"discord","uid":"hubby"} |
#             | startDate   | "2021-01-01T00:00:00.000Z"           |
#             | endDate     | "2022-01-01T00:00:00.000Z"           |
#             | createdOn   | "2021-01-01T00:00:00.000Z"           |
#             | updatedOn   | "2021-01-01T00:00:00.000Z"           |