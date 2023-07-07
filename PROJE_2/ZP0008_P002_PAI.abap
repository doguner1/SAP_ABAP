*&---------------------------------------------------------------------*
*&  Include           ZP0008_P002_PAI
*&---------------------------------------------------------------------*

MODULE USER_COMMAND_1000 INPUT.

  PERFORM call_rows.


  CASE SY-UCOMM.
    WHEN '&BCK'.
      SET SCREEN 0.
    WHEN '&SAVE'.
      PERFORM smartform.
  ENDCASE.
ENDMODULE.