*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library     OperatingSystem
#Library     DataDriver    file=D:/STUDY AUTO/Selenium with python/pets.xlsx    worksheet=Sheet1

Suite Setup    Create Session    mysession    https://petstore.swagger.io/v2    verify=False
#Test Template  Add a new user


*** Variables ***
${Base_URL}     https://petstore.swagger.io
${SCHEMA}       D:/STUDY AUTO/Selenium with python/schema2.json

*** Test Cases ***

Get Store Inventory data
    create session    mysession     ${Base_URL}
    ${response}     GET On Session    mysession        /v2/store/inventory
    log to console    ${response.status_code}
    log to console    ${response.headers}
    ${json_data}    convert string to json    ${response.content}
    log to console      ${json_data}

    ${status_code}      convert to string    ${response.status_code}
    should be equal    ${status_code}   200

    ${res_body}  convert to string    ${response.content}
    should contain    ${res_body}       Clothing

Validate Full JSON
    ${response}=    GET On Session    mysession    /v2/store/inventory
    Validate Json By Schema File    ${response.text}    ${SCHEMA}

Validate Headers
    ${response}=    GET On Session    mysession     /v2/store/inventory
    #${headers}=     create dictionary    Content-type=application/json
    #single header validate
    should be equal     ${response.headers["Content-type"]}     application/json

    #validate multiple headers
    Dictionary Should Contain Key    ${response.headers}    Content-Type
    Dictionary Should Contain Key    ${response.headers}    Access-Control-Allow-Origin
    dictionary should contain key    ${response.headers}    Transfer-Encoding

Post request Order create
    create session    mysession     ${base_url}
    ${Body}     create dictionary       id=265,petId=15
    ${headers}      create dictionary    Content-type=application/json
    ${response}     post request    mysession       /v2/store/order        data=${Body}    headers=${headers}
    log to console    ${response.status_code}
    log to console    ${response.content}


#Post from excel sheet       ${ID}   ${username}    ${firstName}     ${lastName}     ${email}    ${password}     ${phone}    ${userStatus}

#Create And Get Order by same id chaining
#    #create order post req
#    ${id}   set variable    420
#    ${Body}     create dictionary    id=${id}   petId=15    quantity=10     shipDate=2025-08-16T06:23:58.481+0000   status=placed   complete=true
#    ${headers}      create dictionary    Content-type=application/json
#    ${response}     post on session    mysession    /v2/store/order    data=${Body}    headers=${headers}
#    log to console    POST Status:  ${response.status_code}
#    log to console    POST Body:    ${response.text}
#    should be equal as integers    ${response.status_code}  200
#
#    #use same id above one to get data
#
#    ${get_response}     get on session    mysession     /v2/store/order/${id}
#    log to console    Get Response Status: ${get_response.status_code}
#    log to console    Get Body: ${get_response.text}
#    should be equal as integers    ${get_response.status_code}  200


#Update Existing Pet put
#    # Body of the pet we want to update
#    ${photoUrls}=    Create List
#    ${tags}=    Create List
#    ${body}=    Create Dictionary
#    ...    id=1001
#    ...    name=doggie
#    ...    status=available
#    ...    category=${None}
#    ...    photoUrls=${photoUrls}
#    ...    tags=${tags}
#
#    ${headers}=    Create Dictionary    Content-Type=application/json
#    # PUT request
#    ${response}=    Put On Session    mysession    /pet    json=${body}    headers=${headers}
#    Log To Console    PUT Status: ${response.status_code}
#    Log To Console    PUT Body: ${response.text}
#    Should Be Equal As Integers    ${response.status_code}    200


*** Keywords ***

#Add a new user
#    [Arguments]    ${ID}   ${username}    ${firstName}     ${lastName}     ${email}    ${password}     ${phone}    ${userStatus}
#    ${Body}     create dictionary    ID=${ID}   username=${username}    firstName=${firstName}  lastName=${lastName}    email=${email}  password=${password}    phone=${phone}  userStatus=${userStatus}
#    ${resp}=    post on session    mysession    /user     json=${Body}
#    log to console    Response: ${resp.text}
#    should be equal as integers    ${resp.status_code}      200


#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>    EXTRA    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

#getting data from excel,sheet in dictionary

#*** Settings ***
#Library    RequestsLibrary
#Library    DataDriver    file=D:/STUDY AUTO/Selenium with python/pets.xlsx    worksheet=Orders
#Test Template    Create And Get Order by same id chaining
#
#*** Test Cases ***
#Order from Excel
#
#*** Keywords ***
#Create And Get Order by same id chaining
#    [Arguments]    ${id}    ${petId}    ${quantity}    ${shipDate}    ${status}    ${complete}
#    ${Body}     create dictionary    id=${id}   petId=${petId}    quantity=${quantity}   shipDate=${shipDate}   status=${status}   complete=${complete}
#    ${headers}  create dictionary    Content-type=application/json
#    ${response}     post on session    mysession    /store/order    json=${Body}    headers=${headers}
#    log to console    POST Status: ${response.status_code}
#    log to console    POST Body: ${response.text}
#    should be equal as integers    ${response.status_code}    200
#    ${get_response}     get on session    mysession     /store/order/${id}
#    log to console    Get Response Status: ${get_response.status_code}
#    log to console    Get Body: ${get_response.text}
#    should be equal as integers    ${get_response.status_code}    200
#
#
##getting data from sheet in for loop
#
#*** Settings ***
#Library    RequestsLibrary
#Library    RPA.Excel.Files
#
#*** Test Cases ***
#Post Order From Excel
#    Open Workbook    D:/STUDY AUTO/Selenium with python/pets.xlsx
#    ${rows}=    Read Worksheet As Table     header=True
#    Close Workbook
#    FOR    ${row}    IN    @{rows}
#        ${id}=    Set Variable    ${row}[id]
#        ${petId}=    Set Variable    ${row}[petId]
#        ${quantity}=    Set Variable    ${row}[quantity]
#        ${shipDate}=    Set Variable    ${row}[shipDate]
#        ${status}=    Set Variable    ${row}[status]
#        ${complete}=    Set Variable    ${row}[complete]
#
#        ${Body}=    Create Dictionary    id=${id}    petId=${petId}    quantity=${quantity}    shipDate=${shipDate}    status=${status}    complete=${complete}
#        ${headers}=    Create Dictionary    Content-type=application/json
#        ${response}=    Post On Session    mysession    /store/order    json=${Body}    headers=${headers}
#        Log To Console    POST Status: ${response.status_code}
#    END
