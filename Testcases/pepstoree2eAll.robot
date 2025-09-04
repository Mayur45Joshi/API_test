*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary

Suite Setup    Create Session    mysession    https://petstore.swagger.io/v2    verify=False


*** Test Cases ***
Create, Update And Get Pet
    # -------------------------------------------------
    # Step 1: Create a Pet (POST /pet)
    # -------------------------------------------------
    ${photoUrls}=    Create List
    ${tags}=         Create List

    ${pet_body}=    Create Dictionary
    ...    id=1001
    ...    name=Tommy
    ...    status=available
    ...    category=${None}
    ...    photoUrls=${photoUrls}
    ...    tags=${tags}

    ${headers}=    Create Dictionary    Content-Type=application/json

    ${post_response}=    Post On Session    mysession    /pet    json=${pet_body}    headers=${headers}
    Log To Console    POST Status: ${post_response.status_code}
    Log To Console    POST Body: ${post_response.text}
    Should Be Equal As Integers    ${post_response.status_code}    200

    # -------------------------------------------------
    # Step 2: Update Pet (PUT /pet)
    # -------------------------------------------------
    ${updated_body}=    Create Dictionary
    ...    id=1001
    ...    name=Rocky
    ...    status=sold
    ...    category=${None}
    ...    photoUrls=${photoUrls}
    ...    tags=${tags}

    ${put_response}=    Put On Session    mysession    /pet    json=${updated_body}    headers=${headers}
    Log To Console    PUT Status: ${put_response.status_code}
    Log To Console    PUT Body: ${put_response.text}
    Should Be Equal As Integers    ${put_response.status_code}    200

    # -------------------------------------------------
    # Step 3: Get Updated Pet (GET /pet/{id})
    # -------------------------------------------------
    ${get_response}=    Get On Session    mysession    /pet/1001
    Log To Console    GET Status: ${get_response.status_code}
    Log To Console    GET Body: ${get_response.text}
    Should Be Equal As Integers    ${get_response.status_code}    200
    Should Contain    ${get_response.text}    Rocky
    Should Contain    ${get_response.text}    sold

    # -------------------------------------------------
    # Step 4: Delete Pet (DELETE /pet/{id})
    # -------------------------------------------------
    ${delete_response}=    Delete On Session    mysession    /pet/1001
    Log To Console    DELETE Status: ${delete_response.status_code}
    Log To Console    DELETE Body: ${delete_response.text}
    Should Be Equal As Integers    ${delete_response.status_code}    200

    # -------------------------------------------------
    # Step 5: Verify Pet Deleted (GET should return 404)
    # -------------------------------------------------
    ${get_after_delete}=    Get On Session    mysession    /pet/1001
    Log To Console    GET After DELETE Status: ${get_after_delete.status_code}
    Log To Console    GET After DELETE Body: ${get_after_delete.text}
    Should Be Equal As Integers    ${get_after_delete.status_code}    404