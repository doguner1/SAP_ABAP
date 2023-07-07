*&---------------------------------------------------------------------*
*&  Include           ZP0008_P004_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM GET_DATA .
    SELECT * FROM SCARR
      INTO TABLE GT_SCARR.
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  SET_FCAT
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM SET_FCAT .
  
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        I_STRUCTURE_NAME       = 'SCARR'
      CHANGING
        CT_FIELDCAT            = GT_FCAT
      EXCEPTIONS
        INCONSISTENT_INTERFACE = 1
        PROGRAM_ERROR          = 2
        OTHERS                 = 3.
    IF SY-SUBRC <> 0.
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  SET_LAYOUT
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM SET_LAYOUT .
    CLEAR: GS_FCAT.
    GS_LAYOUT-SEL_MODE = 'A'.
    GS_LAYOUT-ZEBRA = ABAP_TRUE.
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  SMARTFORM
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM SMARTFORM .
    LOOP AT IT_SELECTED_ROWS INTO LS_SELECTED_ROW.
      READ TABLE GT_SCARR INTO DATA(LS_SCARR) INDEX LS_SELECTED_ROW-INDEX.
      IF SY-SUBRC = 0.
        APPEND LS_SCARR TO GT_SCARR2.
      ENDIF.
    ENDLOOP.
  
  
  
    GS_CONTROLS-NO_DIALOG = ABAP_TRUE.
    GS_CONTROLS-PREVIEW = ABAP_TRUE.
    "Pupop çıktısını kapatık
    GS_OUTPUT_OPT-TDDEST = 'LP01'.
    "Burada yazıcıyı otomatik gönderdik
  
  ******  CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
  ******    EXPORTING
  ******      FORMNAME = 'ZP0008_SF002'
  ******    IMPORTING
  ******      FM_NAME  = GV_FM_NAME.
  ******
  ******
  ******  CALL FUNCTION GV_FM_NAME
  ******    EXPORTING
  ******      CONTROL_PARAMETERS = GS_CONTROLS
  ******      OUTPUT_OPTIONS     = GS_OUTPUT_OPT
  ******      USER_SETTINGS      = ''
  ******      IT_SCARR           = GT_SCARR2.
  
    CALL FUNCTION '/1BCDWB/SF00000006'
      EXPORTING
  *     ARCHIVE_INDEX      =
  *     ARCHIVE_INDEX_TAB  =
  *     ARCHIVE_PARAMETERS =
        CONTROL_PARAMETERS = GS_CONTROLS
  *     MAIL_APPL_OBJ      =
  *     MAIL_RECIPIENT     =
  *     MAIL_SENDER        =
        OUTPUT_OPTIONS     = GS_OUTPUT_OPT
        USER_SETTINGS      = ' '
        IT_SCARR           = GT_SCARR2
  *  IMPORTING
  *     DOCUMENT_OUTPUT_INFO       =
  *     JOB_OUTPUT_INFO    =
  *    JOB_OUTPUT_OPTIONS         =.
      .
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  CALL_ROWS
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM CALL_ROWS .
    CALL METHOD GO_ALV->GET_SELECTED_ROWS
      IMPORTING
        ET_INDEX_ROWS = IT_SELECTED_ROWS.
  
  ENDFORM.
  
  FORM DOWN_EXCEL.
  
      LOOP AT IT_SELECTED_ROWS INTO LS_SELECTED_ROW.
      READ TABLE GT_SCARR INTO DATA(LS_SCARR) INDEX LS_SELECTED_ROW-INDEX.
      IF SY-SUBRC = 0.
        APPEND LS_SCARR TO GT_SCARR2.
      ENDIF.
    ENDLOOP.
  
    GET REFERENCE OF GT_SCARR2 INTO LR_EXCEL_STRUCTURE.
        GET REFERENCE OF GT_SCARR2 INTO LR_EXCEL_STRUCTURE.
      DATA(LO_ITAB_SERVICES) = CL_SALV_ITAB_SERVICES=>CREATE_FOR_TABLE_REF( LR_EXCEL_STRUCTURE ).
      LO_SOURCE_TABLE_DESCR ?= CL_ABAP_TABLEDESCR=>DESCRIBE_BY_DATA_REF( LR_EXCEL_STRUCTURE ).
      LO_TABLE_ROW_DESCRIPTOR ?= LO_SOURCE_TABLE_DESCR->GET_TABLE_LINE_TYPE( ).
  
      DATA(LO_TOOL_XLS) = CL_SALV_EXPORT_TOOL_ATS_XLS=>CREATE_FOR_EXCEL(
      EXPORTING R_DATA = LR_EXCEL_STRUCTURE ) .
  
      DATA(LO_CONFIG) = LO_TOOL_XLS->CONFIGURATION( ).
  
    LO_CONFIG->ADD_COLUMN(
        EXPORTING
          HEADER_TEXT          =   'CARR ID'               " The column header label
          FIELD_NAME           =   'CARRID'               " The structure component name in the data table structure
          DISPLAY_TYPE         =   IF_SALV_BS_MODEL_COLUMN=>UIE_TEXT_VIEW               " The column display type
  *   RECEIVING
  *     COLUMN_CONFIGURATION =                  " The created column configuration object
      ).
  
    LO_CONFIG->ADD_COLUMN(
        EXPORTING
          HEADER_TEXT          =   'CARR NAME'               " The column header label
          FIELD_NAME           =   'CARRNAME'               " The structure component name in the data table structure
          DISPLAY_TYPE         =   IF_SALV_BS_MODEL_COLUMN=>UIE_TEXT_VIEW               " The column display type
  *   RECEIVING
  *     COLUMN_CONFIGURATION =                  " The created column configuration object
      ).
  
    LO_CONFIG->ADD_COLUMN(
        EXPORTING
          HEADER_TEXT          =   'PB'               " The column header label
          FIELD_NAME           =   'CURRCODE'               " The structure component name in the data table structure
          DISPLAY_TYPE         =   IF_SALV_BS_MODEL_COLUMN=>UIE_TEXT_VIEW               " The column display type
  *   RECEIVING
  *     COLUMN_CONFIGURATION =                  " The created column configuration object
      ).
  
    LO_CONFIG->ADD_COLUMN(
        EXPORTING
          HEADER_TEXT          =   'URL'               " The column header label
          FIELD_NAME           =   'URL'               " The structure component name in the data table structure
          DISPLAY_TYPE         =   IF_SALV_BS_MODEL_COLUMN=>UIE_TEXT_VIEW               " The column display type
  *   RECEIVING
  *     COLUMN_CONFIGURATION =                  " The created column configuration object
      ).
  
    TRY .
        LO_TOOL_XLS->READ_RESULT( IMPORTING CONTENT =   LV_CONTENT ) .
      CATCH
        CX_ROOT INTO DATA(EXCPTION).
    ENDTRY.
  
  
    CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
      EXPORTING
        BUFFER        = LV_CONTENT
  *     APPEND_TO_TABLE       = ' '
      IMPORTING
        OUTPUT_LENGTH = LV_LENGHT
      TABLES
        BINARY_TAB    = LT_BINARY_TAB.
  
    CONCATENATE 'SCARR' SY-DATUM SY-UZEIT INTO LV_FIELNAME SEPARATED BY '-'.
  
     CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG
          EXPORTING
            WINDOW_TITLE      = 'Enter File Name'
            DEFAULT_EXTENSION = 'XLSX'
            DEFAULT_FILE_NAME = LV_FIELNAME
          CHANGING
            FILENAME          = LV_FIELNAME
            PATH              = LV_PATH
            FULLPATH          = LV_FULLPATH.
  
            CALL FUNCTION 'GUI_DOWNLOAD'
            EXPORTING
              BIN_FILESIZE = LV_LENGHT
              FILENAME     = LV_FULLPATH
              FILETYPE     = 'BIN'
  
            TABLES
              DATA_TAB     = LT_BINARY_TAB
  
            .
          IF SY-SUBRC <> 0.
  * Implement suitable error handling here
          ENDIF.
  
            CALL METHOD CL_GUI_FRONTEND_SERVICES=>EXECUTE
            EXPORTING
              DOCUMENT = LV_FULLPATH.
  ENDFORM.