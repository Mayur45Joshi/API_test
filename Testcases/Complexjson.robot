*** Settings ***

Library     JSONLibrary
Library     os
Library     Collections
Library    RequestsLibrary

*** Variables ***

${Bearer_Token}     2707|5VZ8sK7kEx0jPOjql5tszrHsPjNNltX80uM3G260
${Base_url}      https://restfulcountries.com/api/v1
*** Test Cases ***

TC1:Complexjson

    create session    mysession     ${Base_URL}
    ${header}=  create dictionary    Content-type=application/json; charset=utf-8   Authorization=Bearer=${Bearer_Token}
    ${response}=    get request    mysession    /countries
    log to console    ${response.status_code}
    log to console    ${response.content}