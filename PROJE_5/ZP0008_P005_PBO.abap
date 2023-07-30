

*&---------------------------------------------------------------------*
*&      Module  STATUS_1000  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_1000 OUTPUT.
  SET PF-STATUS '0100'.
*  SET TITLEBAR 'xxx'.
ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  STATUS_1001  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_1001 OUTPUT.
  SET PF-STATUS '0100'.
*  SET TITLEBAR 'xxx'.
ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  STATUS_1002  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_1002 OUTPUT.
  SET PF-STATUS '0200'.
*  SET TITLEBAR 'xxx'.

  IF  DOCKINGLEFT IS INITIAL  .

    CREATE OBJECT DOCKINGLEFT
      EXPORTING
        REPID     = REPID
        DYNNR     = SY-DYNNR
        SIDE      = DOCKINGLEFT->DOCK_AT_BOTTOM
        EXTENSION = 80.

    CREATE OBJECT TEXT_EDITOR
      EXPORTING
        PARENT = DOCKINGLEFT.

  ENDIF.
ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  STATUS_1004  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_1004 OUTPUT.
  SET PF-STATUS '0100'.
*  SET TITLEBAR 'xxx'.
ENDMODULE.



*&---------------------------------------------------------------------*
*&      Module  STATUS_1005  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_1005 OUTPUT.

  SET PF-STATUS '0100'.
*  SET TITLEBAR 'xxx'.

  CREATE OBJECT GO_CONT
    EXPORTING                        "Cont Oluşturduk, oluşturduğumuz cont'un idsini verdik
      CONTAINER_NAME = 'CC_RAPOR'.

"---------------------------------------------------------
  CREATE OBJECT GO_ALV
    EXPORTING                        "Oluşturduğunuz cont'ub objesini ALV nin cont alanına verdik
      I_PARENT = GO_CONT.

"---------------------------------------------------------

  CREATE OBJECT GO_EVENT_RECEIVER.
  SET HANDLER GO_EVENT_RECEIVER->HANDLE_TOOLBAR2      FOR GO_ALV.
  SET HANDLER GO_EVENT_RECEIVER->HANDLE_USER_COMMAND2 FOR GO_ALV.

  CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      IS_LAYOUT       = GS_LAYOUT
    CHANGING
      IT_OUTTAB       = GT_VISIT          " Output Table
      IT_FIELDCATALOG = GT_FCAT.

  "---------------------------------------------------------









ENDMODULE.



*&---------------------------------------------------------------------*
*&      Module  STATUS_1006  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_1006 OUTPUT.
  SET PF-STATUS '0300'.
*  SET TITLEBAR 'xxx'.
  PERFORM DISPLAY_ALV.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_1007  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_1007 OUTPUT.
  SET PF-STATUS '0300'.
*  SET TITLEBAR 'xxx'.

  PERFORM DISPLAY_AVL2.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_1008  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_1008 OUTPUT.
  SET PF-STATUS '0300'.
*  SET TITLEBAR 'xxx'.
  PERFORM DISPLAY_ALV3.
ENDMODULE.