*** Settings ***
Library    RequestsLibrary

*** Variables ***

${Base_URL}     https://reqres.in/       #http://restapi.demoqa.com
#${City}     Delhi

*** Test Cases ***

GetWeatherInfo
    create session    mysession     ${Base_URL}
    ${response} =   get request    mysession    /api/users?page=2
#    log to console    ${response.status_code}
#    log to console    ${response.content}
#    log to console    ${response.headers}

    #validations

    ${status_code}=     convert to string      ${response.status_code}
    should be equal      ${status_code}   200

    ${body}     convert to string    ${response.content}
    should contain    ${body}       Michael

    ${contentvalue} =  set variable      ${response.headers.get('Content-Type')}
    should be equal    ${contentvalue}      	application/json; charset=utf-8