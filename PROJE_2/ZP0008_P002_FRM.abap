*&---------------------------------------------------------------------*
*&  Include           ZP0008_P002_FRM
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
  
    DATA:
      LV_BIN_FILESIZE TYPE I.
  
    DATA: ITOTF    TYPE STANDARD TABLE OF ITCOO,
          IT_TLINE TYPE STANDARD TABLE OF TLINE.
  
    LOOP AT IT_SELECTED_ROWS INTO LS_SELECTED_ROW.
      READ TABLE GT_SCARR INTO DATA(LS_SCARR) INDEX LS_SELECTED_ROW-INDEX.
      IF SY-SUBRC = 0.
        APPEND LS_SCARR TO GT_SCARR2.
      ENDIF.
    ENDLOOP.
  
  
    GS_CONTROLS-NO_DIALOG = ABAP_TRUE.
    GS_CONTROLS-PREVIEW = ABAP_TRUE.
    GS_CONTROLS-GETOTF = 'X'.
  *  Pupop çıktısını kapatık
    GS_OUTPUT_OPT-TDDEST = 'LP01'.
  *  Burada yazıcıyı otomatik gönderdik
  
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
      IMPORTING
  *     DOCUMENT_OUTPUT_INFO       =
        JOB_OUTPUT_INFO    = JOB_OUTPUT_INFO.
  
  
    ITOTF = JOB_OUTPUT_INFO-OTFDATA.
  
    CALL FUNCTION 'CONVERT_OTF'
      EXPORTING
        FORMAT                = 'PDF'
  *      MAX_LINEWIDTH         = 132
  *     ARCHIVE_INDEX         = ' '
  *     COPYNUMBER            = 0
  *     ASCII_BIDI_VIS2LOG    = ' '
  *     PDF_DELETE_OTFTAB     = ' '
  *     PDF_USERNAME          = ' '
  *     PDF_PREVIEW           = ' '
  *     USE_CASCADING         = ' '
  *     MODIFIED_PARAM_TABLE  =
      IMPORTING
        BIN_FILESIZE          = LV_BIN_FILESIZE
  *     BIN_FILE              =
      TABLES
        OTF                   = ITOTF
        LINES                 = IT_TLINE
      EXCEPTIONS
        ERR_MAX_LINEWIDTH     = 1
        ERR_FORMAT            = 2
        ERR_CONV_NOT_POSSIBLE = 3
        ERR_BAD_OTF           = 4
        OTHERS                = 5.
    IF SY-SUBRC <> 0.
  * Implement suitable error handling here
    ENDIF.
  
    CALL FUNCTION 'GUI_DOWNLOAD'
      EXPORTING
       BIN_FILESIZE            = LV_BIN_FILESIZE
        FILENAME                = 'C:\Users\qwert\Desktop\Deneme.pdf'
        FILETYPE                = 'BIN'
  *       IMPORTING
  *     FILELENGTH              =
      TABLES
        DATA_TAB                = IT_TLINE
  *     FIELDNAMES              =
      EXCEPTIONS
        FILE_WRITE_ERROR        = 1
        NO_BATCH                = 2
        GUI_REFUSE_FILETRANSFER = 3
        INVALID_TYPE            = 4
        NO_AUTHORITY            = 5
        UNKNOWN_ERROR           = 6
        HEADER_NOT_ALLOWED      = 7
        SEPARATOR_NOT_ALLOWED   = 8
        FILESIZE_NOT_ALLOWED    = 9
        HEADER_TOO_LONG         = 10
        DP_ERROR_CREATE         = 11
        DP_ERROR_SEND           = 12
        DP_ERROR_WRITE          = 13
        UNKNOWN_DP_ERROR        = 14
        ACCESS_DENIED           = 15
        DP_OUT_OF_MEMORY        = 16
        DISK_FULL               = 17
        DP_TIMEOUT              = 18
        FILE_NOT_FOUND          = 19
        DATAPROVIDER_EXCEPTION  = 20
        CONTROL_FLUSH_ERROR     = 21
        OTHERS                  = 22.
    IF SY-SUBRC <> 0.
  * Implement suitable error handling here
    ENDIF.
  
  
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