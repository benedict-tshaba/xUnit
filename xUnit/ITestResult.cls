INTERFACE xUnit.ITestResult:
    METHOD PUBLIC VOID testStarted ().
    METHOD PUBLIC VOID testFailed ( INPUT test AS CHARACTER,
                                    INPUT err  AS Progress.Lang.Error ).
    METHOD PUBLIC CHARACTER summary ().
END INTERFACE.