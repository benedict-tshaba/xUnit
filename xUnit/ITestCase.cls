USING xUnit.ITestResult.

INTERFACE xUnit.ITestCase:
    DEFINE PUBLIC  PROPERTY TestResults AS ITestResult NO-UNDO GET. SET.

    METHOD PUBLIC VOID before ().
    METHOD PUBLIC VOID setUp ().
    METHOD PUBLIC VOID run ( INPUT oResult AS ITestResult ).
    METHOD PUBLIC VOID runAll ( INPUT oResult AS ITestResult ).
    METHOD PUBLIC VOID tearDown ().
    METHOD PUBLIC VOID after ().
END INTERFACE.