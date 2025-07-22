*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***

${Base_URL}     https://reqres.in/

*** Test Cases ***

APIBasicAuth
    ${auth}     create list    Username     password
    create session    mysession     ${Base_URL}         auth=${auth}
    ${response}=    get request    mysession    /relative url
    log to console    ${response.content}
    should be equal as strings    ${response.status_code}   200


