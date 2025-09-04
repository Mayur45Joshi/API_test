*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary

Suite Setup    Create Session    mysession    https://yourapi.com    verify=False

*** Variables ***
${USERNAME}    myuser
${PASSWORD}    mypass

*** Test Cases ***
Get JWT Token And Use It
    # Step 1: Login and get token
    ${login_body}=    Create Dictionary    username=${USERNAME}    password=${PASSWORD}
    ${headers}=       Create Dictionary    Content-Type=application/json
    ${response}=      Post On Session    mysession    /auth/login    json=${login_body}    headers=${headers}

    Log To Console    Login Response: ${response.text}
    Should Be Equal As Integers    ${response.status_code}    200

    ${json}=    To Json    ${response.text}
    ${token}=   Get Value From Json    ${json}    $.token
    Log To Console    Retrieved Token: ${token[0]}

    # Step 2: Use token in another request
    ${auth_headers}=    Create Dictionary    Authorization=Bearer ${token[0]}    Content-Type=application/json
    ${get_response}=    Get On Session    mysession    /user/profile    headers=${auth_headers}

    Log To Console    GET Response: ${get_response.text}
    Should Be Equal As Integers    ${get_response.status_code}    200
