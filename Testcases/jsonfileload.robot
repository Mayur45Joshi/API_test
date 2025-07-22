*** Settings ***
Library     JSONLibrary
Library     os
Library     Collections


*** Test Cases ***

TC1
    ${json_data}=   load json from file    D:/STUDY AUTO/Selenium with python/API.json
    ${name_value}=  get value from json    ${json_data}     $.firstName
    #log to console    ${name_value}
    should be equal    ${name_value[0]}    John

    ${street_value}=    get value from json    ${json_data}     $.address[0].street
    should be equal    ${street_value[0]}            123 Main St

    ${Fax_num}      get value from json    ${json_data}     $.numbers.fax.number
    log to console    ${Fax_num}
    should be equal    ${Fax_num[0]}       123-456-7891
