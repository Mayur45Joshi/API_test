import pytest
from robot import run

@pytest.mark.smoke
@pytest.mark.api
def test_create_and_get_order():
    result = run(
        "pytestRobot/pepstore.robot",
        test="Create Pet",
        log="logs/log_create.html",
        report="logs/report_create.html",
        output="logs/output_create.xml"
    )
    assert result == 0   # Robot returns 0 if all tests pass

@pytest.mark.regression
@pytest.mark.api
def test_update_pet():
    result = run(
        "pytestRobot/pepstore.robot",
        test="Update Pet By ID",
        log="logs/log_update.html",
        report="logs/report_update.html",
        output="logs/output_update.xml"
    )
    assert result == 0

@pytest.mark.regression
@pytest.mark.api
def test_delete_pet():
    result = run(
        "pytestRobot/pepstore.robot",
        test="Delete Pet By ID",
        log="logs/log_delete.html",
        report="logs/report_delete.html",
        output="logs/output_delete.xml"
    )
    assert result == 0




