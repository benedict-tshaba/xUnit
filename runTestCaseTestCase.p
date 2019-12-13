USING xUnit.TestResult.
USING xUnit.tests.TestCaseTest.

DEFINE VARIABLE oTestCaseTest  AS TestCaseTest NO-UNDO.
DEFINE VARIABLE oTestResult    AS TestResult   NO-UNDO.
                                                   
oTestCaseTest  = NEW TestCaseTest().
oTestResult    = NEW TestResult().

/* Run the test cases */
oTestCaseTest:runAll(oTestResult).

/* Output the results */
MESSAGE
    oTestCaseTest:TestResults:SUMMARY() 
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK TITLE "TestCase Test Results".

DELETE OBJECT oTestCaseTest.