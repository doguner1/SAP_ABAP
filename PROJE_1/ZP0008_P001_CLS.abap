*&---------------------------------------------------------------------*
*&  Include           ZP0008_P001_CLS
*&---------------------------------------------------------------------*
CLASS CL_EVENT_RECEIVER DEFINITION.
    PUBLIC SECTION.
      METHODS HANDLE_TOP_OF_PAGE                   "Yukarıya başlık alanı açtığımız yapı
          FOR EVENT TOP_OF_PAGE OF CL_GUI_ALV_GRID
        IMPORTING
          E_DYNDOC_ID
          TABLE_INDEX.
  
      METHODS HANDLE_HOTSPOT_CLICK                  "Bir hücrenin tıklanabilir özelliği
          FOR EVENT HOTSPOT_CLICK OF CL_GUI_ALV_GRID
        IMPORTING
          E_ROW_ID
          E_COLUMN_ID.
  
      METHODS HANDLE_DOUBLE_CLICK                  "Bir satırın tıklanabilir özelliği
          FOR EVENT DOUBLE_CLICK OF CL_GUI_ALV_GRID
        IMPORTING
          E_ROW
          E_COLUMN
          ES_ROW_NO.
  
      METHODS HANDLE_DATA_CHANGED                  "Yapılan değişikleri içerde loglama ve değişiklik yapma
          FOR EVENT DATA_CHANGED OF CL_GUI_ALV_GRID
        IMPORTING
          ER_DATA_CHANGED
          E_ONF4
          E_ONF4_BEFORE
          E_ONF4_AFTER
          E_UCOMM.
  
      METHODS HANDLE_ONF4
          FOR EVENT ONF4 OF CL_GUI_ALV_GRID
        IMPORTING
          E_FIELDNAME
          E_FIELDVALUE
          ES_ROW_NO
          ER_EVENT_DATA
          ET_BAD_CELLS
          E_DISPLAY.
  
      METHODS HANDLE_BUTTON_CLICK
          FOR EVENT BUTTON_CLICK OF CL_GUI_ALV_GRID
        IMPORTING
          ES_COL_ID
          ES_ROW_NO.
  
      METHODS HANDLE_TOOLBAR
          FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID
        IMPORTING
          E_OBJECT
          E_INTERACTIVE.
  
      METHODS HANDLE_USER_COMMAND
          FOR EVENT USER_COMMAND OF CL_GUI_ALV_GRID
        IMPORTING
          E_UCOMM.
  
  ENDCLASS.
  
  CLASS CL_EVENT_RECEIVER IMPLEMENTATION.
    METHOD HANDLE_TOP_OF_PAGE.
      DATA: LV_TEXT TYPE SDYDO_TEXT_ELEMENT.
  
      LV_TEXT = 'FLIGHT DETAILS'.
  
      CALL METHOD GO_DOCU->ADD_TEXT
        EXPORTING
          TEXT      = LV_TEXT
          SAP_STYLE = CL_DD_DOCUMENT=>HEADING.
  
      CALL METHOD GO_DOCU->NEW_LINE.
  
      CLEAR: LV_TEXT.
  
      CONCATENATE 'User: ' SY-UNAME INTO LV_TEXT SEPARATED BY SPACE.
  
      CALL METHOD GO_DOCU->ADD_TEXT
        EXPORTING
          TEXT         = LV_TEXT
          SAP_COLOR    = CL_DD_DOCUMENT=>LIST_POSITIVE
          SAP_FONTSIZE = CL_DD_DOCUMENT=>MEDIUM.
  
      CALL METHOD GO_DOCU->DISPLAY_DOCUMENT
        EXPORTING
          PARENT = GO_SUB1.
    ENDMETHOD.
  
    METHOD HANDLE_HOTSPOT_CLICK.
      BREAK-POINT.
    ENDMETHOD.
  
    METHOD HANDLE_DOUBLE_CLICK.
      BREAK-POINT.
    ENDMETHOD.
  
    METHOD HANDLE_DATA_CHANGED.
      BREAK-POINT.
    ENDMETHOD.
  
    METHOD HANDLE_ONF4.
      BREAK-POINT.
    ENDMETHOD.
  
   METHOD HANDLE_BUTTON_CLICK.
      BREAK-POINT.
    ENDMETHOD.
  
    METHOD HANDLE_TOOLBAR.
      DATA: ls_toolbar TYPE stb_button.
  
      CLEAR: LS_TOOLBAR.
      LS_TOOLBAR-FUNCTION  = '&SFORM'.
      LS_TOOLBAR-TEXT      = 'Form'.
      LS_TOOLBAR-ICON      = '@0X@'.
      LS_TOOLBAR-QUICKINFO = 'SmartForma Bas'.
      APPEND ls_toolbar to E_OBJECT->MT_TOOLBAR.
    ENDMETHOD.
  
    METHOD HANDLE_USER_COMMAND.
      CASE E_UCOMM.
        WHEN '&SFORM'.
          PERFORM call_rows.
          PERFORM smartform.
      ENDCASE.
    ENDMETHOD.
  ENDCLASS.