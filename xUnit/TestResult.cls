BLOCK-LEVEL ON ERROR UNDO, THROW.

/* TestResult.cls
*  The TestResult Class, records unit test results. The idea is you never run
*  this code in isolation, you must instantiate it and pass it in the run
*  method of a TestCase instance.
*  Author: Tshaba Phomolo Benedict
*  Version: 0.0.1-2019
*  Notes: Do not modify this code unless;
*       a) You know what you're doing.
*       b) You have done this before.
*       c) You're me :-)
*/

CLASS xUnit.TestResult :

  DEFINE PRIVATE PROPERTY RunCount   AS INTEGER   NO-UNDO GET. SET.
  DEFINE PRIVATE PROPERTY FailCount  AS INTEGER   NO-UNDO GET. SET.
  DEFINE PRIVATE PROPERTY FailReason AS CHARACTER NO-UNDO GET. SET.

  CONSTRUCTOR TestResult 
    () :

    ASSIGN
      THIS-OBJECT:RunCount  = 0
      THIS-OBJECT:FailCount = 0.

  END CONSTRUCTOR.

  METHOD PUBLIC LOGICAL testStarted
    ():

    ASSIGN
      THIS-OBJECT:RunCount = RunCount + 1.

  END METHOD.

  METHOD PUBLIC LOGICAL testFailed
    ( INPUT test AS CHARACTER,
      INPUT err  AS Progress.Lang.ERROR ):

    DEFINE VARIABLE iNumMessages AS INTEGER NO-UNDO.

    DO iNumMessages = 1 TO err:NumMessages:
      ASSIGN
        THIS-OBJECT:FailReason = THIS-OBJECT:FailReason + test + "~t> ":U + err:GetMessage(iNumMessages) + "~n":U.
    END.

    ASSIGN
      THIS-OBJECT:FailCount = THIS-OBJECT:FailCount + 1.

  END METHOD.

  METHOD PUBLIC CHARACTER summary
    ():

    DEFINE VARIABLE cSummary AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE cFailure AS CHARACTER   NO-UNDO.
    
    ASSIGN
      cSummary = STRING(THIS-OBJECT:RunCount) + " run, ":U + STRING(THIS-OBJECT:FailCount) + " failed.":U
      cFailure = "~nFailures:~n":U + THIS-OBJECT:FailReason
      cSummary = cSummary + cFailure WHEN THIS-OBJECT:FailCount > 0.

    RETURN cSummary.

  END METHOD.

END CLASS.