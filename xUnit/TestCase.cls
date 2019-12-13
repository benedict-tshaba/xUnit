BLOCK-LEVEL ON ERROR UNDO, THROW.

/* TestCase.cls
*  The TestCase SuperClass, every unit test case class inherits this bad boy
*  Author: Tshaba Phomolo Benedict
*  Version: 0.0.1-2019
*  Notes: Do not modify this code unless;
*       a) You know what you're doing.
*       b) You have done this before.
*       c) You're me :-)
*/

USING Progress.Lang.*. 
USING Progress.Reflect.*. 

USING xUnit.TestResult.

CLASS xUnit.TestCase :

  DEFINE PRIVATE PROPERTY TestName    AS CHARACTER  NO-UNDO GET. SET.
  DEFINE PUBLIC  PROPERTY TestResults AS TestResult NO-UNDO GET. SET.
  DEFINE PRIVATE VARIABLE lReturnVal  AS LOGICAL    NO-UNDO.

  CONSTRUCTOR TestCase
    ( INPUT testName AS CHARACTER ):

    ASSIGN
      THIS-OBJECT:TestName = testName.

  END CONSTRUCTOR.

  CONSTRUCTOR TestCase
    ():
  END CONSTRUCTOR.

  METHOD PUBLIC LOGICAL setUp
    ():
  END METHOD.

  METHOD PUBLIC LOGICAL run
    ( INPUT oResult AS TestResult ):

    ASSIGN
      THIS-OBJECT:TestResults = oResult
      lReturnVal              = THIS-OBJECT:TestResults:testStarted()
      lReturnVal              = THIS-OBJECT:setUp()
      lReturnVal              = DYNAMIC-INVOKE(THIS-OBJECT, THIS-OBJECT:TestName).

    CATCH err AS Progress.Lang.ERROR:
      lReturnVal              = THIS-OBJECT:TestResults:testFailed(THIS-OBJECT:TestName, err).
    END CATCH.

    FINALLY:
      lReturnVal              = THIS-OBJECT:tearDown().
    END FINALLY.
  END METHOD.

  METHOD PUBLIC LOGICAL runAll
    ( INPUT oResult AS TestResult ):

    DEFINE VARIABLE oMethods AS CLASS Method   EXTENT NO-UNDO.
    DEFINE VARIABLE iMax     AS INTEGER NO-UNDO.
    DEFINE VARIABLE iLoop    AS INTEGER NO-UNDO.

    ASSIGN 
      EXTENT(oMethods) = ?
      oMethods         = THIS-OBJECT:GetClass():GetMethods()
      iMax             = EXTENT(oMethods).

    DO iLoop = 1 TO iMax:
      IF oMethods[iLoop]:NAME BEGINS "test":U
      THEN DO:
        THIS-OBJECT:TestName = oMethods[iLoop]:NAME.
        THIS-OBJECT:RUN(oResult).
      END.
    END.

  END METHOD.

  METHOD PUBLIC LOGICAL tearDown
    ():
  END METHOD.

END CLASS.