*** Settings ***
Library     RequestsLibrary
Library    Collections


*** Variables ***
${Base_URL}     https://jsonplaceholder.typicode.com/

*** Test Cases ***

Testcase2
    create session    mysession     ${Base_URL}
    ${response}     get request    mysession    /photos
    log to console    ${response.headers}

    ${content_value}    get from Dictionary     ${response.headers}     Content-Type
    should be equal    ${content_value}     application/json; charset=utf-8

    ${contentencodevalue}   get from dictionary    ${response.headers}      Content-Encoding
    should be equal    ${contentencodevalue}    gzip

    log to console    ${response.cookies}

#    ${cookievalue}  get from dictionary    ${response.cookies}      cfL4
#    log to console    {cookievalue}
