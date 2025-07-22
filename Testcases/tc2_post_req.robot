*** Settings ***

Library    RequestsLibrary
Library    Collections

*** Variables ***

${Base_URL}     https://simple-books-api.glitch.me
${Bearer_Token}        d1daff819e90c7a5c5966a7364976ddfad39e40028ad57cb45d2c2e635fa960c
*** Test Cases ***

Post-request_for register
    create session    mysession     ${Base_URL}
    ${body} =   create dictionary    bookId=1,customerName=MJ
    ${header}=  create dictionary    Content-type=application/json; charset=utf-8   Authorization=Bearer=${Bearer_Token}
    ${response}=    post request    mysession   /orders     data=${body}    headers=${header}

    log to console    ${response.status_code}
    log to console    ${response.content}