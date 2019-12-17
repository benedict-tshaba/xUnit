BLOCK-LEVEL ON ERROR UNDO, THROW.

/* TestCase.cls
*  The TestCase SuperClass, every unit test case class inherits this bad boy
*  Author: Tshaba Phomolo Benedict
*  Version: 1.0.0-2019
*  Notes: Do not modify this code unless;
*       a) You know what you're doing.
*       b) You have done this before.
*       c) You're me :-)
*/

USING Progress.Lang.*. 
USING Progress.Reflect.*. 

USING xUnit.ITestResult.

CLASS xUnit.TestCase IMPLEMENTS xUnit.ITestCase:

  DEFINE PRIVATE PROPERTY TestName    AS CHARACTER   NO-UNDO GET. SET.
  DEFINE PUBLIC  PROPERTY TestResults AS ITestResult NO-UNDO GET. SET.
  DEFINE PRIVATE VARIABLE lReturnVal  AS LOGICAL     NO-UNDO.

  CONSTRUCTOR TestCase
    ( INPUT testName AS CHARACTER ):

    ASSIGN
      THIS-OBJECT:TestName = testName.

  END CONSTRUCTOR.

  CONSTRUCTOR TestCase
    ():
  END CONSTRUCTOR.

  METHOD PUBLIC VOID before
    ():
  END METHOD.

  METHOD PUBLIC VOID setUp
    ():
  END METHOD.

  METHOD PUBLIC VOID run
    ( INPUT oResult AS ITestResult ):

    ASSIGN
      THIS-OBJECT:TestResults = oResult.

    THIS-OBJECT:TestResults:testStarted().
    THIS-OBJECT:setUp().
    DYNAMIC-INVOKE(THIS-OBJECT, THIS-OBJECT:TestName).

    CATCH err AS Progress.Lang.ERROR:
      THIS-OBJECT:TestResults:testFailed(THIS-OBJECT:TestName, err).
    END CATCH.

    FINALLY:
      THIS-OBJECT:tearDown().
    END FINALLY.
  END METHOD.

  METHOD PUBLIC VOID runAll
    ( INPUT oResult AS ITestResult ):

    DEFINE VARIABLE oMethods AS CLASS Method   EXTENT NO-UNDO.
    DEFINE VARIABLE iMax     AS INTEGER NO-UNDO.
    DEFINE VARIABLE iLoop    AS INTEGER NO-UNDO.

    ASSIGN 
      EXTENT(oMethods) = ?
      oMethods         = THIS-OBJECT:GetClass():GetMethods()
      iMax             = EXTENT(oMethods).
    
    THIS-OBJECT:before().

    DO iLoop = 1 TO iMax:
      IF oMethods[iLoop]:NAME BEGINS "test":U
      THEN DO:
        THIS-OBJECT:TestName = oMethods[iLoop]:NAME.
        THIS-OBJECT:RUN(oResult).
      END.
    END.

    THIS-OBJECT:after().

  END METHOD.

  METHOD PUBLIC VOID tearDown
    ():
  END METHOD.

  METHOD PUBLIC VOID after
    ():
  END METHOD.

END CLASS.