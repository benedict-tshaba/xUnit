USING xUnit.TestResult.
USING xUnit.tests.TestResultTest.

DEFINE VARIABLE oTestResultTest  AS TestResultTest NO-UNDO.
DEFINE VARIABLE oTestResult      AS TestResult     NO-UNDO.
                                                   
oTestResultTest  = NEW TestResultTest().
oTestResult      = NEW TestResult().

/* Run the test cases */
oTestResultTest:runAll(oTestResult).

/* Output the results */
MESSAGE
    oTestResult:SUMMARY() 
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK TITLE "TestResult Test Results".

DELETE OBJECT oTestResultTest.
DELETE OBJECT oTestResult.