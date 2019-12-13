BLOCK-LEVEL ON ERROR UNDO, THROW.

USING xUnit.TestCase.
USING OpenEdge.Core.Assert.

USING xUnit.TestResult.

CLASS xUnit.tests.TestResultTest INHERITS TestCase :

  DEFINE PRIVATE PROPERTY oTestResult AS TestResult NO-UNDO GET. SET.

  DEFINE VARIABLE lSuccess AS LOGICAL NO-UNDO.

  CONSTRUCTOR TestResultTest
    ():
    SUPER().
  END CONSTRUCTOR.

  CONSTRUCTOR TestResultTest
    ( INPUT methodName AS CHARACTER ):
    SUPER(methodName).
  END CONSTRUCTOR.

  METHOD PUBLIC OVERRIDE LOGICAL setUp
    ():
    THIS-OBJECT:oTestResult = NEW TestResult().
  END METHOD.

  METHOD PUBLIC LOGICAL testTestStartedIncrementsRunCount
    ():
    oTestResult:testStarted().
    Assert:Equals(oTestResult:summary(), "1 run, 0 failed.":U).
  END METHOD.

  METHOD PUBLIC LOGICAL testFiveTestsRanSuccessfullyWithNoFailures
    ():
    oTestResult:testStarted().
    oTestResult:testStarted().
    oTestResult:testStarted().
    oTestResult:testStarted().
    oTestResult:testStarted().
    Assert:Equals(oTestResult:summary(), "5 run, 0 failed.":U).
  END METHOD.

  METHOD PUBLIC LOGICAL testFiveTestsRanWithOneFailure
    ():
    DEFINE VARIABLE cSummary AS CHARACTER NO-UNDO.
    oTestResult:testStarted().
    oTestResult:testStarted().
    oTestResult:testStarted().
    oTestResult:testStarted().
    oTestResult:testStarted().

    cSummary = "5 run, 1 failed.":U
             + "~nFailures:~n":U + "testFiveTestsRanWithOneFailure~t> My Test Passed~n":U.

    oTestResult:testFailed('testFiveTestsRanWithOneFailure', NEW PROGRESS.Lang.AppError("My Test Passed", 666)).
    Assert:Equals(oTestResult:summary(), cSummary).
  END METHOD.

  METHOD PUBLIC LOGICAL testSummaryWhenNoTestsRan
    ():
    Assert:Equals(oTestResult:summary(), "0 run, 0 failed.":U).
  END METHOD.

  METHOD PUBLIC LOGICAL testTestFailedIncrementsFailCount
    ():
    DEFINE VARIABLE cSummary AS CHARACTER NO-UNDO.

    cSummary = "0 run, 1 failed.":U
             + "~nFailures:~n":U + "testTestFailedIncrementsFailCount~t> My Test Passed~n":U.

    oTestResult:testFailed('testTestFailedIncrementsFailCount', NEW PROGRESS.Lang.AppError("My Test Passed", 666)).
    Assert:Equals(oTestResult:summary(), cSummary).
  END METHOD.

  METHOD PUBLIC OVERRIDE LOGICAL tearDown
    ():
    IF VALID-OBJECT(oTestResult) THEN DELETE OBJECT oTestResult.
  END METHOD.

END CLASS.