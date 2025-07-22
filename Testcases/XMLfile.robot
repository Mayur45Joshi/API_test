*** Settings ***

Library     XML
Library     os
Library     Collections


*** Variables ***


*** Test Cases ***

TC1
    ${xml_obj}=     parse xml       D:/STUDY AUTO/Selenium with python/employees.xml

    #approach 1
    ${first_name}=     get element text    ${xml_obj}      .//employee[1]/firstName
    should be equal    ${first_name}    John

    #approach 2

    ${first_name}=     get element    ${xml_obj}      .//employee[1]/firstName
    should be equal    ${first_name.text}       John

    #approach 3
    element text should be    ${xml_obj}    John    .//employee[1]/firstName

    #get element count
    ${count}=   get element count    ${xml_obj}     .//employee
    should be equal as integers    ${count}     6

    #element attribute should be    ${xml_obj}   age     28   .//employee[4]

    #get child element
    ${child_ele}=  get child elements    ${xml_obj}    .//employee[1]
    should not be empty    ${child_ele}

    ${fname}=   get element text    ${child_ele[0]}
    ${lname}=   get element text    ${child_ele[1]}
    ${title}=   get element text    ${child_ele[2]}

    log to console    ${fname}
    log to console    ${lname}
    log to console    ${title}