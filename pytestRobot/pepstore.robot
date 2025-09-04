*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}    https://petstore.swagger.io/v2
${PET_ID}      12345

*** Test Cases ***
Create Pet
    [Documentation]    Create a new pet with fixed ID
    Create Session    mysession    ${BASE_URL}
    ${body}=    Create Dictionary    id=${PET_ID}    name=doggy    status=available
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${resp}=    Post On Session    mysession    /pet    json=${body}    headers=${headers}
    Log    Create Response: ${resp.text}
    Should Be Equal As Integers    ${resp.status_code}    200

Update Pet By ID
    [Documentation]    Update the pet created above
    Create Session    mysession    ${BASE_URL}
    ${body}=    Create Dictionary    id=${PET_ID}    name=doggy-updated    status=sold
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${resp}=    Put On Session    mysession    /pet    json=${body}    headers=${headers}
    Log    Update Response: ${resp.text}
    Should Be Equal As Integers    ${resp.status_code}    200

Delete Pet By ID
    [Documentation]    Delete the pet created above
    Create Session    mysession    ${BASE_URL}
    ${resp}=    Delete On Session    mysession    /pet/${PET_ID}
    Log    Delete Response: ${resp.text}
    Should Be Equal As Integers    ${resp.status_code}    200
