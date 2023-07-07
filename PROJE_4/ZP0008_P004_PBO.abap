*&---------------------------------------------------------------------*
*&  Include           ZP0008_P004_PBO
*&---------------------------------------------------------------------*

MODULE STATUS_1000 OUTPUT.
  SET PF-STATUS '0100'.
  SET TITLEBAR '0100'.

  IF GO_ALV IS INITIAL.

    CREATE OBJECT GO_CONT
      EXPORTING                        "Cont Oluşturduk, oluşturduğumuz cont'un idsini verdik
        CONTAINER_NAME = 'CC_ALV'.

    "---------------------------------------------------------

    CREATE OBJECT GO_SPLI
      EXPORTING
        PARENT  = GO_CONT
        ROWS    = 2
        COLUMNS = 1.

    CALL METHOD GO_SPLI->GET_CONTAINER
      EXPORTING
        ROW       = 1
        COLUMN    = 1
      RECEIVING
        CONTAINER = GO_SUB1.

    CALL METHOD GO_SPLI->GET_CONTAINER
      EXPORTING
        ROW       = 2
        COLUMN    = 1
      RECEIVING
        CONTAINER = GO_SUB2.

    CALL METHOD GO_SPLI->SET_ROW_HEIGHT
      EXPORTING
        ID     = 1
        HEIGHT = 15.

    CREATE OBJECT GO_DOCU
      EXPORTING
        STYLE = 'ALV_GRID'.
    "---------------------------------------------------------
    CREATE OBJECT GO_ALV
      EXPORTING                        "Oluşturduğunuz cont'ub objesini ALV nin cont alanına verdik
        I_PARENT = GO_SUB2.

    "---------------------------------------------------------

    CREATE OBJECT GO_EVENT_RECEIVER.

    SET HANDLER GO_EVENT_RECEIVER->HANDLE_BUTTON_CLICK  FOR GO_ALV.

    SET HANDLER GO_EVENT_RECEIVER->HANDLE_TOP_OF_PAGE   FOR GO_ALV.

    SET HANDLER GO_EVENT_RECEIVER->HANDLE_TOOLBAR       FOR GO_ALV.
    SET HANDLER GO_EVENT_RECEIVER->HANDLE_USER_COMMAND  FOR GO_ALV.


    CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY
      EXPORTING
        IS_LAYOUT       = GS_LAYOUT
      CHANGING
        IT_OUTTAB       = GT_SCARR           " Output Table
        IT_FIELDCATALOG = GT_FCAT.

    CALL METHOD GO_ALV->LIST_PROCESSING_EVENTS
      EXPORTING
        I_EVENT_NAME = 'TOP_OF_PAGE'
        I_DYNDOC_ID  = GO_DOCU.
  ELSE.
    CALL METHOD GO_ALV->REFRESH_TABLE_DISPLAY.
  ENDIF.
ENDMODULE.