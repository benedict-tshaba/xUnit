USING xUnit.ITestCase.
USING xUnit.ITestResult.

INTERFACE xUnit.ITestSuite:
    DEFINE PUBLIC  PROPERTY TestResults AS ITestResult NO-UNDO GET. SET.

    METHOD PUBLIC VOID register ( INPUT testCase AS ITestCase ).
    METHOD PUBLIC VOID add ( INPUT test AS ITestCase ).
    METHOD PUBLIC VOID run ().
    METHOD PUBLIC VOID runAll ().
END INTERFACE.