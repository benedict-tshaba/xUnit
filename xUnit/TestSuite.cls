BLOCK-LEVEL ON ERROR UNDO, THROW.

/* TestSuite.cls
*  The TestSuite Class, you use this baby to run a whole lot of tests from your
*  TestCases all in one go. And the results are compiled and provided in the end.
*  Author: Tshaba Phomolo Benedict
*  Version: 1.0.0-2019
*  Notes: Do not modify this code unless;
*       a) You know what you're doing.
*       b) You have done this before.
*       c) You're me :-)
*/

USING Progress.Lang.*.

USING xUnit.ITestCase.
USING xUnit.ITestResult.
USING xUnit.TestResult.

CLASS xUnit.TestSuite IMPLEMENTS xUnit.ITestSuite:

  DEFINE PRIVATE PROPERTY TestSeq     AS INTEGER     NO-UNDO GET. SET.
  DEFINE PUBLIC  PROPERTY TestResults AS ITestResult NO-UNDO GET. SET.

  DEFINE PRIVATE TEMP-TABLE ttTests
    FIELD iPK  AS INTEGER
    FIELD Test AS OBJECT 
    INDEX IXPK IS PRIMARY UNIQUE iPK.

  DEFINE PRIVATE TEMP-TABLE ttAllTests
    FIELD iPK              AS INTEGER
    FIELD TestCaseInstance AS OBJECT
    INDEX IXPK             IS PRIMARY UNIQUE iPK.

  CONSTRUCTOR TestSuite
    ():

    ASSIGN
      THIS-OBJECT:TestResults = NEW TestResult().

    EMPTY TEMP-TABLE ttTests.

  END CONSTRUCTOR.
  
  DESTRUCTOR TestSuite
    ():

    IF VALID-OBJECT(THIS-OBJECT:TestResults) 
    THEN 
      DELETE OBJECT THIS-OBJECT:TestResults.

    FOR EACH ttTests:
      IF VALID-OBJECT(ttTests.Test) 
      THEN 
        DELETE OBJECT ttTests.Test.
    END.

    FOR EACH ttAllTests:
      IF VALID-OBJECT(ttAllTests.TestCaseInstance) 
      THEN 
        DELETE OBJECT ttAllTests.TestCaseInstance.
    END.

    EMPTY TEMP-TABLE ttTests.
    EMPTY TEMP-TABLE ttAllTests.

  END DESTRUCTOR.

  METHOD PUBLIC VOID register
    ( INPUT testCase AS ITestCase ):

    CREATE ttAllTests.
    ASSIGN
      TestSeq                      = TestSeq   + 1
      ttAllTests.iPK               = THIS-OBJECT:TestSeq  
      ttAllTests.TestCaseInstance  = testCase.

  END METHOD.

  METHOD PUBLIC VOID add
    ( INPUT test AS ITestCase ):

    CREATE ttTests.
    ASSIGN
      TestSeq      = TestSeq   + 1
      ttTests.iPK  = THIS-OBJECT:TestSeq  
      ttTests.Test = test.

  END METHOD.

  METHOD PUBLIC VOID run
    ():

    FOR EACH ttTests:
      CAST(ttTests.Test, ITestCase):RUN(THIS-OBJECT:TestResults).
    END.

  END METHOD.

  METHOD PUBLIC VOID runAll
    ():

    FOR EACH ttAllTests:
      CAST(ttAllTests.TestCaseInstance, ITestCase):runAll(THIS-OBJECT:TestResults).
    END.

  END METHOD.

END CLASS.