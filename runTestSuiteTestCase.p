USING xUnit.TestResult.
USING xUnit.tests.TestSuiteTest.

DEFINE VARIABLE oTestSuiteTest  AS TestSuiteTest NO-UNDO.
DEFINE VARIABLE oTestResult     AS TestResult    NO-UNDO.
                                                   
oTestSuiteTest  = NEW TestSuiteTest().
oTestResult     = NEW TestResult().

/* Run the test cases */
oTestSuiteTest:runAll(oTestResult).

/* Output the results */
MESSAGE
    oTestSuiteTest:TestResults:SUMMARY() 
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK TITLE "TestSuite Test Results".

DELETE OBJECT oTestSuiteTest.