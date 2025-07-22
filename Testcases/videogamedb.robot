*** Settings ***

Library    RequestsLibrary
Library    Collections

*** Variables ***

${Base_URL}     https://videogamedb.uk:443


*** Test Cases ***

TC1-Returen all videogames GET
    create session    mysession     ${Base_URL}
    ${response}=    get request    mysession    /api/videogame
    log to console    ${response.status_code}
    log to console    ${response.content}

    ${status_code}=     convert to string    ${response.status_code}
    should be equal    ${status_code}   200

TC2-Create new game POST
    create session    mysession     ${Base_URL}
    ${body}     create dictionary       id=11,category=Platform,name= jetha,rating=Mature,releaseDate=2023-02-18 23:59:59
    ${header}   create dictionary   Content-type=application/json
    ${response1}=    post request    mysession     api/videogame     data=${body}      headers=${header}

    log to console    ${response1.status_code}
    log to console    ${response1.content}

    ${status_code}=     convert to string    ${response1.status_code}
    should be equal    ${status_code}   200

TC-3 Get specfic data by id
    create session    mysession     ${Base_URL}
    ${response}=    get request    mysession    api/videogame/10
    log to console    ${response.status_code}
    log to console    ${response.content}

    ${status_code}      convert to string    ${response.status_code}
    should be equal    ${status_code}   200

    ${res_body}     convert to string    ${response.content}
    should contain    ${res_body}   10

TC4-Update existing data PUT
    create session    mysession     ${Base_URL}
    ${body}     create dictionary       id=10,category=Platform,name= jetha,rating=Mature,releaseDate=2023-02-18 23:59:59
    ${header}   create dictionary   Content-type=application/json
    ${response}=    put request    mysession     api/videogame/10     data=${body}      headers=${header}

    log to console    ${response.status_code}
    log to console    ${response.content}

    ${status_code}=     convert to string    ${response.status_code}
    should be equal    ${status_code}   200

    ${res_body}=     convert to string       ${response.content}
    should contain    ${res_body}       jetha

TC-5 Delete specfic data by id
    create session    mysession     ${Base_URL}
    ${response}=    delete request    mysession    api/videogame/10
    log to console    ${response.status_code}
    log to console    ${response.content}

    ${status_code}      convert to string    ${response.status_code}
    should be equal    ${status_code}   200

    ${res_body}     convert to string    ${response.content}
    should contain    ${res_body}   Record deleted successfully