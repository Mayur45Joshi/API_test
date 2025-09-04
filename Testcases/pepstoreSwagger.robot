#*** Settings ***
#Library    REST    ${SWAGGER_FILE}
#
#*** Variables ***
#${SWAGGER_FILE}    swagger.json
#${BASE_URL}        https://petstore.swagger.io/v2
#${PET_ID}          999
#
#*** Test Cases ***
#Add New Pet
#    ${photoUrls}=    Create List    https://example.com/photo.jpg
#    ${body}=    Create Dictionary
#    ...    id=${PET_ID}
#    ...    name=RoboDog
#    ...    photoUrls=${photoUrls}
#    ...    status=available
#    POST    ${BASE_URL}/pet    ${body}
#    Integer    response status    200
#    Object     response body     required=["id", "name"]
#
#Get Pet By ID
#    GET    ${BASE_URL}/pet/${PET_ID}
#    Integer    response status    200
#    Object     response body     required=["id", "category", "name", "photoUrls"]
#
#Find Pets By Status
#    GET    ${BASE_URL}/pet/findByStatus?status=available
#    Integer    response status    200
#    ${body}=    Output    response body
#    Array      ${body}
#    ${len}=    Get Length    ${body}
#    Should Be True    ${len} > 0


#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://petstore.swagger.io/v2
${PET_ID}      10
${STATUS}      available

*** Test Cases ***

Get Pet By ID
    Create Session    petstore    ${BASE_URL}
    ${resp}=    GET On Session    petstore    /pet/${PET_ID}    verify=${False}
    Status Should Be    200    ${resp}
    ${body}=    Evaluate    ${resp.json()}
    Dictionary Should Contain Key    ${body}    category
    Should Be Equal    ${body["name"]}    doggie

Find Pets By Status
    Create Session    petstore    ${BASE_URL}
    ${resp}=    GET On Session    petstore    url=/pet/findByStatus?status=${STATUS}    verify=${False}
    Status Should Be    200    ${resp}
    ${pets}=    Evaluate    ${resp.json()}
    ${first_pet}=    Get From List    ${pets}    0
    Dictionary Should Contain Key    ${first_pet}    status
    Should Be Equal    ${first_pet["status"]}    ${STATUS}

Add New Pet
    Create Session    petstore    ${BASE_URL}
    ${category}=    Create Dictionary    id=1    name=Dogs
    ${photoUrls}=    Create List    https://example.com/photo.jpg
    ${tags}=    Create List    ${EMPTY}    # or create tag dict if needed
    ${tag1}=    Create Dictionary    id=1    name=Cute
    Set List Value    ${tags}    0    ${tag1}
    ${payload}=    Create Dictionary
    ...    id=1234567
    ...    category=${category}
    ...    name=Rex
    ...    photoUrls=${photoUrls}
    ...    tags=${tags}
    ...    status=available
    ${resp}=    POST On Session    petstore    /pet    json=${payload}    verify=${False}
    Status Should Be    200    ${resp}
    ${body}=    Evaluate    ${resp.json()}
    Should Be Equal    ${body["name"]}    Rex
