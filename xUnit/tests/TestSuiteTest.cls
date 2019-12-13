BLOCK-LEVEL ON ERROR UNDO, THROW.

USING xUnit.TestCase.
USING xUnit.TestSuite.
USING OpenEdge.Core.Assert.

CLASS xUnit.tests.TestSuiteTest INHERITS TestCase :

  DEFINE PRIVATE PROPERTY oTestSuite AS TestSuite NO-UNDO GET. SET.

  DEFINE VARIABLE lSuccess AS LOGICAL NO-UNDO.

  CONSTRUCTOR TestSuiteTest
    ():
    SUPER().
  END CONSTRUCTOR.

  CONSTRUCTOR TestSuiteTest
    ( INPUT methodName AS CHARACTER ):
    SUPER(methodName).
  END CONSTRUCTOR.

  METHOD PUBLIC OVERRIDE LOGICAL setUp
    ():
    THIS-OBJECT:oTestSuite = NEW TestSuite().
  END METHOD.

  METHOD PUBLIC LOGICAL testCanAddTestCaseInstance
    ():
    oTestSuite:add(NEW xUnit.tests.TestResultTest('testFiveTestsRanSuccessfullyWithNoFailures')).
    oTestSuite:run().
    Assert:Equals("1 run, 0 failed.", oTestSuite:TestResults:summary()).
  END METHOD.

  METHOD PUBLIC LOGICAL testCanRegisterTestCases
    ():
    oTestSuite:register(NEW xUnit.tests.TestResultTest()).
    oTestSuite:runAll().
    Assert:Equals("5 run, 0 failed.", oTestSuite:TestResults:summary()).
  END METHOD.

  METHOD PUBLIC OVERRIDE LOGICAL tearDown
    ():
    IF VALID-OBJECT(oTestSuite) THEN DELETE OBJECT oTestSuite.
  END METHOD.

END CLASS.