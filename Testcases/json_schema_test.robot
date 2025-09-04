*** Settings ***
Library           JSONLibrary
Library           OperatingSystem

*** Variables ***
${SCHEMA_PATH}=   D:/STUDY AUTO/Selenium with python/schema.json

*** Test Cases ***
Validate JSON Response Against Schema
    # Sample JSON response (you can replace this with actual API response)
    ${response}=    Evaluate    {"id": 1, "username": "john_doe", "email": "john@example.com", "isActive": True}    json

    # Load the schema file as string
    ${schema_string}=    Get File    ${SCHEMA_PATH}

    # Convert schema string to JSON object
    ${schema}=    Evaluate    json.loads('''${schema_string}''')    json

    # Validate
    Validate Json By Schema    ${response}    ${schema}
