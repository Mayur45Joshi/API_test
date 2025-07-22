*** Settings ***

Library    RequestsLibrary
Library    Collections
Library    OperatingSystem


*** Variables ***
${Base_URL}     https://certtransaction.elementexpress.com/
${bearerToken}      "Bearer <ExpressResponseMessage>Invalid Request</ExpressResponseMessage>"

*** Test Cases ***
BearerTokenAuth
    create session    mysession     ${Base_URL}
    ${headers}      create dictionary    Authorisazation=${bearerToken}     Content-Type=text/xml
    ${req_body}=    get file    C:/Selenium/file.txt

    ${response}=    post request    mysession   /   data=${req_body}    headers=${headers}
    log to console    ${response.status_code}
    log to console    ${response.content}


