BLOCK-LEVEL ON ERROR UNDO, THROW.

USING xUnit.TestCase.
USING xUnit.TestResult.
USING xUnit.TestSuite.
USING OpenEdge.Core.Assert.

CLASS xUnit.tests.TestCaseTest INHERITS TestCase :

  DEFINE PRIVATE PROPERTY oTestCase   AS TestCase   NO-UNDO GET. SET.
  DEFINE PRIVATE PROPERTY oTestResult AS TestResult NO-UNDO GET. SET.
  DEFINE PRIVATE PROPERTY oTestSuite  AS TestSuite  NO-UNDO GET. SET.
  DEFINE PRIVATE PROPERTY WasRun      AS LOGICAL    NO-UNDO GET. SET.
  DEFINE PRIVATE PROPERTY TestLog     AS CHARACTER  NO-UNDO GET. SET.

  DEFINE VARIABLE lSuccess AS LOGICAL NO-UNDO.

  CONSTRUCTOR TestCaseTest
    ():
    SUPER().
  END CONSTRUCTOR.

  CONSTRUCTOR TestCaseTest
    ( INPUT methodName AS CHARACTER ):
    SUPER(methodName).
  END CONSTRUCTOR.

  METHOD PUBLIC OVERRIDE LOGICAL setUp
    ():
    THIS-OBJECT:oTestCase   = NEW TestCase().
    THIS-OBJECT:oTestResult = NEW TestResult().
    THIS-OBJECT:oTestSuite  = NEW TestSuite().
    THIS-OBJECT:WasRun = TRUE.
    THIS-OBJECT:TestLog = "setUp ".
  END METHOD.

  METHOD PUBLIC LOGICAL testMethod
    (): /* Nothing special here */
    ASSIGN 
      WasRun  = TRUE
      TestLog = TestLog + "testMethod ".

    Assert:Equals("setUp testMethod", THIS-OBJECT:TestLog).
  END METHOD.

  METHOD PUBLIC LOGICAL testSetUpWasRun
    ():
    oTestCase:run(oTestResult).
    Assert:Equals(TRUE, THIS-OBJECT:WasRun).
    Assert:Equals("setUp ", THIS-OBJECT:TestLog).
  END METHOD.

  METHOD PUBLIC LOGICAL testTemplateMethod
    (): /* Nothing special here */
    ASSIGN 
      WasRun  = TRUE
      TestLog = TestLog + "testTemplateMethod ".

    oTestCase:run(oTestResult).
    Assert:Equals("setUp testTemplateMethod", THIS-OBJECT:TestLog).
  END METHOD.

  METHOD PUBLIC LOGICAL testSuiteWithAdd
    ():
    oTestSuite:add(NEW xUnit.tests.TestCaseTest('testTemplateMethod')).
    oTestSuite:add(NEW xUnit.tests.TestCaseTest('testMethod')).
    oTestSuite:run().
    Assert:Equals("2 run, 0 failed.", oTestSuite:TestResults:SUMMARY()).
  END METHOD.

  METHOD PUBLIC LOGICAL testSuiteWithRegister
    ():
    oTestSuite:register(NEW xUnit.tests.TestResultTest()).
    oTestSuite:register(NEW xUnit.tests.TestSuiteTest()).
    oTestSuite:runAll().
    Assert:Equals("7 run, 0 failed.", oTestSuite:TestResults:SUMMARY()).
  END METHOD.

  METHOD PUBLIC OVERRIDE LOGICAL tearDown
    ():
    ASSIGN 
      WasRun  = TRUE
      TestLog = TestLog + "tearDown ".
    IF VALID-OBJECT(oTestCase)   THEN DELETE OBJECT oTestCase.
    IF VALID-OBJECT(oTestResult) THEN DELETE OBJECT oTestResult.
    IF VALID-OBJECT(oTestSuite)  THEN DELETE OBJECT oTestSuite.
  END METHOD.

END CLASS.