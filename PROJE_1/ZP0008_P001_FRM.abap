*&---------------------------------------------------------------------*
*&  Include           ZP0008_P001_FRM
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
       I_STRUCTURE_NAME = 'SCARR'
      CHANGING
        CT_FIELDCAT = gt_fcat
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
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
  
        CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
          EXPORTING
            FORMNAME = 'ZP0008_SF002'
          IMPORTING
            FM_NAME  = GV_FM_NAME.
  
  
        CALL FUNCTION GV_FM_NAME
          EXPORTING
            CONTROL_PARAMETERS = GS_CONTROLS
            OUTPUT_OPTIONS     = GS_OUTPUT_OPT
            USER_SETTINGS      = ''
            IT_SCARR           = GT_SCARR2.
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