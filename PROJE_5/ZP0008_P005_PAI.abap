
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1000  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_1000 INPUT.
  CASE SY-UCOMM.
    WHEN '&BCK'.
      LEAVE PROGRAM.
    WHEN '&GIRIS'.
      PERFORM GIRIS.
  ENDCASE.
ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1001  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_1001 INPUT.
  CASE SY-UCOMM.
    WHEN '&BCK'.
      SET SCREEN 0.
    WHEN '&RAPOR'.
      PERFORM RAPOR.
    WHEN '&GORUNTULE'.
       CLEAR: GT_VISIT, GS_VISIT.
      PERFORM GORUNTULE.
  ENDCASE.
ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1002  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_1002 INPUT.
  CASE SY-UCOMM.
    WHEN 'ENTER'.
      SELECT SINGLE EMID FROM ZP0008_T0018 WHERE EMID = @GV_EMID INTO CORRESPONDING FIELDS OF @GS_EMP.
      IF NOT GS_EMP-EMID IS INITIAL.
        PERFORM VISITSAVE.
      ELSE.
        MESSAGE 'Employers Kayıtlı Değil' TYPE 'I'.
        SET SCREEN 0.
      ENDIF.
      WHEN 'CANSEL'.
        PERFORM CANSEL.
        LEAVE TO SCREEN 0.
    ENDCASE.
ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1004  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_1004 INPUT.
  CASE SY-UCOMM.
    WHEN '&BCK'.
      call SCREEN 1000.
    WHEN '&RAPOR'.
      PERFORM RAPOR.
    WHEN '&GORUNTULE'.
      PERFORM GORUNTULE.
    WHEN '&RAPORSIL'.
      PERFORM RAPORSIL.
    WHEN '&RAPORGUNCELLE'.
      PERFORM RAPORGUNCELLE.
  ENDCASE.
ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1005  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_1005 INPUT.
  CASE SY-UCOMM.
    WHEN '&BCK'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1006  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_1006 INPUT.
  CASE SY-UCOMM.
    WHEN '&BCK'.
      SET SCREEN 0.
    WHEN '&DELETE'.
      PERFORM ROWS.
      PERFORM DELETE.
  ENDCASE.
ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1007  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_1007 INPUT.
  CASE SY-UCOMM.
    WHEN '&BCK'.
      LEAVE TO SCREEN 0..
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1008  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_1008 INPUT.
  CASE SY-UCOMM.
    WHEN '&BCK'.
      CALL SCREEN 1004.
  ENDCASE.
ENDMODULE.