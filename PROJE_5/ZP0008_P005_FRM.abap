
*&---------------------------------------------------------------------*
*&      Form  RAPORGUNCELLE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM RAPORGUNCELLE .
    CLEAR: GT_VISIT, GS_VISIT.
  
    SELECT * FROM ZP0008_T0020
  INTO TABLE GT_VISIT.
  
    CLEAR: GS_FCAT , GS_LAYOUT.
    GS_LAYOUT-EDIT = 'X'.
  
  
    CALL SCREEN 1007 STARTING AT 85 8.
  ENDFORM.
  
  
  
  *&---------------------------------------------------------------------*
  *&      Form  FCAT
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM FCAT .
    CLEAR: GS_FCAT.
    GS_FCAT-FIELDNAME = 'EMID'.
    GS_FCAT-SCRTEXT_S = 'EmpID'.
    GS_FCAT-SCRTEXT_S = 'EmployerID'.
    GS_FCAT-SCRTEXT_S = 'EmployerID'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR: GS_FCAT.
    GS_FCAT-FIELDNAME = 'CUSID'.
    GS_FCAT-SCRTEXT_S = 'CusID'.
    GS_FCAT-SCRTEXT_S = 'CustomerID'.
    GS_FCAT-SCRTEXT_S = 'CustomerID'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR: GS_FCAT.
    GS_FCAT-FIELDNAME = 'TARIH'.
    GS_FCAT-SCRTEXT_S = 'Tarih'.
    GS_FCAT-SCRTEXT_S = 'Tarih'.
    GS_FCAT-SCRTEXT_S = 'Tarih'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR: GS_FCAT.
    GS_FCAT-FIELDNAME = 'ZIYARETTUR'.
    GS_FCAT-SCRTEXT_S = 'ZTürü'.
    GS_FCAT-SCRTEXT_S = 'ZiyaretTürü'.
    GS_FCAT-SCRTEXT_S = 'ZiyaretTürü'.
    GS_FCAT-COL_OPT = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR: GS_FCAT.
    GS_FCAT-FIELDNAME = 'YAPILANIS'.
    GS_FCAT-SCRTEXT_S = 'İş'.
    GS_FCAT-SCRTEXT_S = 'Yapılanİş'.
    GS_FCAT-SCRTEXT_S = 'Yapılanİş'.
    GS_FCAT-COL_OPT = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
  ENDFORM.
  
  
  
  
  *&---------------------------------------------------------------------*
  *&      Form  DISPLAY_ALV
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM DISPLAY_ALV .
  
        CLEAR: GS_FCAT , GS_LAYOUT ,GT_VISIT,GS_VISIT, IT_SELECTED_ROWS.
    GS_LAYOUT-SEL_MODE = 'A'.
    GS_LAYOUT-ZEBRA = ABAP_TRUE.
    SELECT * FROM ZP0008_T0020
    INTO TABLE GT_VISIT.
  
    CREATE OBJECT GO_CONT
      EXPORTING                        "Cont Oluşturduk, oluşturduğumuz cont'un idsini verdik
        CONTAINER_NAME = 'CC_RAPORS'.
  
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
        IT_OUTTAB       = GT_VISIT          " Output Table
        IT_FIELDCATALOG = GT_FCAT.
  
    CALL METHOD GO_ALV->LIST_PROCESSING_EVENTS
      EXPORTING
        I_EVENT_NAME = 'TOP_OF_PAGE'
        I_DYNDOC_ID  = GO_DOCU.
  *  ELSE.
  *    CALL METHOD GO_ALV->REFRESH_TABLE_DISPLAY.
  *  ENDIF.
  
  ENDFORM.
  
  
  
  *&---------------------------------------------------------------------*
  *&      Form  RAPORSIL
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM RAPORSIL .
  
    CALL SCREEN 1006 STARTING AT 85 8.
  ENDFORM.
  
  
  *&---------------------------------------------------------------------*
  *&      Form  VISITSAVE
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM VISITSAVE .
  
    CLEAR: GT_VISIT,GS_VISIT.
    SELECT * FROM ZP0008_T0020
  INTO TABLE GT_VISIT.
  
    CALL METHOD TEXT_EDITOR->GET_TEXT_AS_R3TABLE
      IMPORTING
        TABLE  = ITEXT
      EXCEPTIONS
        OTHERS = 1.
  
    " ITEXT tablosundaki metni alın
  
    LOOP AT ITEXT INTO XTEXT.
      CONCATENATE LV_MESSAGE XTEXT INTO LV_MESSAGE SEPARATED BY ' '.
    ENDLOOP.
  
    IF LV_MESSAGE IS NOT INITIAL.
      CLEAR GS_VISIT.
      GS_VISIT-EMID = GV_EMID.
      GS_VISIT-CUSID = GV_CUSID.
      GS_VISIT-TARIH = SY-DATUM.
      GS_VISIT-ZIYARETTUR = GV_ZIYARETTUR.
      GS_VISIT-YAPILANIS = LV_MESSAGE.
      GS_VISIT-RAPORID = GV_RAPORID.
      INSERT ZP0008_T0020 FROM GS_VISIT.
      COMMIT WORK AND WAIT.
    ENDIF.
    MESSAGE 'Eklendi' TYPE 'I'.
  
  
    " Metin alanını temizle
    CLEAR ITEXT.
    CALL METHOD TEXT_EDITOR->SET_TEXT_AS_R3TABLE
      EXPORTING
        TABLE  = ITEXT
      EXCEPTIONS
        OTHERS = 1.
    CLEAR: GV_EMID,GV_CUSID,GV_TARIH,GV_YAPILANIS,GV_ZIYARETTUR,LV_MESSAGE,ITEXT,XTEXT.
  
    GV_RAPORID = GV_RAPORID + 1.
  
    SELECT SINGLE EMID FROM ZP0008_T0018 WHERE EMNICKNAME = @GV_EMNICKNAME INTO @DATA(GS_EMIP).
  
    GV_EMID = GS_EMIP.
  ENDFORM.
  
  
  
  
  *&---------------------------------------------------------------------*
  *&      Form  RAPOR
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM RAPOR .
    SELECT SINGLE EMID FROM ZP0008_T0018 WHERE EMNICKNAME = @GV_EMNICKNAME INTO @DATA(GS_EMIP).
  
    GV_EMID = GS_EMIP.
  
    CLEAR: GT_VISIT,GS_VISIT.
    SELECT * FROM ZP0008_T0020
  INTO TABLE GT_VISIT.
    CALL SCREEN 1002 STARTING AT 85 8.
  
  ENDFORM.
  
  
  *&---------------------------------------------------------------------*
  *&      Form  GIRIŞ
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM GIRIS .
    SELECT SINGLE EMNICKNAME, EMSIFRE FROM ZP0008_T0018 WHERE EMNICKNAME = @GV_EMNICKNAME AND EMSIFRE = @GV_EMSIFRE INTO CORRESPONDING FIELDS OF @GS_EMP.
  
    IF  GS_EMP-EMNICKNAME IS INITIAL AND GS_EMP-EMSIFRE IS INITIAL.
      MESSAGE 'Kullanıcı adınız veya şifreniz yanlış' TYPE 'I' .
    ELSE.
  
      SELECT SINGLE EMID FROM ZP0008_T0018 WHERE EMNICKNAME = @GV_EMNICKNAME INTO @DATA(GS_EMIP).
  
      GV_EMID = GS_EMIP.
  
      IF  GS_EMP-EMNICKNAME EQ 'D.GUNR' AND GS_EMP-EMSIFRE EQ 'DODO'.
        CALL SCREEN 1004.
      ELSE.
        CALL SCREEN 1001.
      ENDIF.
    ENDIF.
  
  
  ENDFORM.
  
  
  *&---------------------------------------------------------------------*
  *&      Form  GORUNTULE
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM GORUNTULE .
  
    CLEAR: GT_VISIT, GS_VISIT,GS_FCAT , GS_LAYOUT.
    GS_LAYOUT-SEL_MODE = 'A'.
    GS_LAYOUT-ZEBRA = ABAP_TRUE.
  
    SELECT * FROM ZP0008_T0020
  INTO TABLE GT_VISIT.
  
  
    CALL SCREEN 1005.
  ENDFORM.
  
  
  *&---------------------------------------------------------------------*
  *&      Form  CANSEL
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM CANSEL .
  
    " Metin alanını temizle
    CLEAR ITEXT.
    CALL METHOD TEXT_EDITOR->SET_TEXT_AS_R3TABLE
      EXPORTING
        TABLE  = ITEXT
      EXCEPTIONS
        OTHERS = 1.
    CLEAR: GV_EMID,GV_CUSID,GV_TARIH,GV_YAPILANIS,GV_ZIYARETTUR,LV_MESSAGE,ITEXT,XTEXT.
  ENDFORM.
  
  *
  *FORM create_alv_grid USING p_container_name TYPE string.
  *
  *  CREATE OBJECT go_cont
  *    EXPORTING
  *      container_name = p_container_name.
  *
  *  CREATE OBJECT go_alv
  *    EXPORTING
  *      i_parent = go_cont.
  *
  *  CALL METHOD go_alv->set_table_for_first_display
  *    EXPORTING
  *      is_layout         = gs_layout
  *      i_structure_name  = 'ZP0008_ST005'
  *    CHANGING
  *      it_outtab         = gt_visit
  *      it_fieldcatalog   = gt_fcat.
  *ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  DISPLAY_AVL2
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM DISPLAY_AVL2 .
  
    CLEAR: GT_VISIT,GS_VISIT.
    SELECT * FROM ZP0008_T0020
  INTO TABLE GT_VISIT.
    CREATE OBJECT GO_CONT
      EXPORTING                        "Cont Oluşturduk, oluşturduğumuz cont'un idsini verdik
        CONTAINER_NAME = 'CC_RAPORGUNCELLE'.
  
    "---------------------------------------------------------
    CREATE OBJECT GO_ALV
      EXPORTING                        "Oluşturduğunuz cont'ub objesini ALV nin cont alanına verdik
        I_PARENT = GO_CONT.
  
    "---------------------------------------------------------
    CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY
      EXPORTING
        IS_LAYOUT        = GS_LAYOUT
        I_STRUCTURE_NAME = 'ZP0008_ST005'
      CHANGING
        IT_OUTTAB        = GT_VISIT
        IT_FIELDCATALOG  = GT_FCAT.
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  DELETE
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM DELETE .
  
    LOOP AT IT_SELECTED_ROWS INTO LS_SELECTED_ROW.
      READ TABLE GT_VISIT INTO GS_VISIT2 INDEX LS_SELECTED_ROW-INDEX.
      IF SY-SUBRC = 0.
        APPEND GS_VISIT2 TO GT_VISIT2.
        DELETE FROM ZP0008_T0020 WHERE RAPORID EQ GS_VISIT2-RAPORID.
      ENDIF.
    ENDLOOP.
    MESSAGE 'Silindi' TYPE 'I'.
  
    CLEAR: GT_VISIT, GS_VISIT.
  
    SELECT * FROM ZP0008_T0020
  INTO TABLE GT_VISIT.
  
    CALL SCREEN 1008 STARTING AT 85 8.
  
      CLEAR: GT_VISIT, GS_VISIT.
  
    SELECT * FROM ZP0008_T0020
  INTO TABLE GT_VISIT.
  
    CALL METHOD GO_ALV->GET_SELECTED_ROWS
      IMPORTING
        ET_INDEX_ROWS = IT_SELECTED_ROWS.
  
    CLEAR: IT_SELECTED_ROWS.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  ROWS
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM ROWS .
    CALL METHOD GO_ALV->GET_SELECTED_ROWS
      IMPORTING
        ET_INDEX_ROWS = IT_SELECTED_ROWS.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  DISPLAY_ALV3
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM DISPLAY_ALV3 .
  
    CLEAR: GT_VISIT,GS_VISIT.
    SELECT * FROM ZP0008_T0020
  INTO TABLE GT_VISIT.
  
    CREATE OBJECT GO_CONT
      EXPORTING                        "Cont Oluşturduk, oluşturduğumuz cont'un idsini verdik
        CONTAINER_NAME = 'CC_SILINDI'.
  
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
        IT_OUTTAB       = GT_VISIT          " Output Table
        IT_FIELDCATALOG = GT_FCAT.
  
    CALL METHOD GO_ALV->LIST_PROCESSING_EVENTS
      EXPORTING
        I_EVENT_NAME = 'TOP_OF_PAGE'
        I_DYNDOC_ID  = GO_DOCU.
  *  ELSE.
  *    CALL METHOD GO_ALV->REFRESH_TABLE_DISPLAY.
  *  ENDIF.
  
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
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  DOWN_EXCEL
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM DOWN_EXCEL .
    LOOP AT IT_SELECTED_ROWS INTO LS_SELECTED_ROW.
      READ TABLE GT_VISIT INTO GS_VISIT2 INDEX LS_SELECTED_ROW-INDEX.
      IF SY-SUBRC = 0.
        APPEND GS_VISIT2 TO GT_VISIT2.
      ENDIF.
    ENDLOOP.
  
  
    GET REFERENCE OF GT_VISIT2 INTO LR_EXCEL_STRUCTURE.
    GET REFERENCE OF GT_VISIT2 INTO LR_EXCEL_STRUCTURE.
    DATA(LO_ITAB_SERVICES) = CL_SALV_ITAB_SERVICES=>CREATE_FOR_TABLE_REF( LR_EXCEL_STRUCTURE ).
    LO_SOURCE_TABLE_DESCR ?= CL_ABAP_TABLEDESCR=>DESCRIBE_BY_DATA_REF( LR_EXCEL_STRUCTURE ).
    LO_TABLE_ROW_DESCRIPTOR ?= LO_SOURCE_TABLE_DESCR->GET_TABLE_LINE_TYPE( ).
  
    DATA(LO_TOOL_XLS) = CL_SALV_EXPORT_TOOL_ATS_XLS=>CREATE_FOR_EXCEL(
    EXPORTING R_DATA = LR_EXCEL_STRUCTURE ) .
  
    DATA(LO_CONFIG) = LO_TOOL_XLS->CONFIGURATION( ).
  
    LO_CONFIG->ADD_COLUMN(
        EXPORTING
          HEADER_TEXT          =   'Rapor ID'               " The column header label
          FIELD_NAME           =   'RAPORID'               " The structure component name in the data table structure
          DISPLAY_TYPE         =   IF_SALV_BS_MODEL_COLUMN=>UIE_TEXT_VIEW               " The column display type
  ).
  
    LO_CONFIG->ADD_COLUMN(
        EXPORTING
          HEADER_TEXT          =   'Customer ID'               " The column header label
          FIELD_NAME           =   'CUSID'               " The structure component name in the data table structure
          DISPLAY_TYPE         =   IF_SALV_BS_MODEL_COLUMN=>UIE_TEXT_VIEW               " The column display type
   ).
  
    LO_CONFIG->ADD_COLUMN(
        EXPORTING
          HEADER_TEXT          =   'Tarih'               " The column header label
          FIELD_NAME           =   'TARIH'               " The structure component name in the data table structure
          DISPLAY_TYPE         =   IF_SALV_BS_MODEL_COLUMN=>UIE_TEXT_VIEW               " The column display type
    ).
  
    LO_CONFIG->ADD_COLUMN(
        EXPORTING
          HEADER_TEXT          =   'Saat'               " The column header label
          FIELD_NAME           =   'SAAT'               " The structure component name in the data table structure
          DISPLAY_TYPE         =   IF_SALV_BS_MODEL_COLUMN=>UIE_TEXT_VIEW               " The column display type
   ).
  
    LO_CONFIG->ADD_COLUMN(
      EXPORTING
        HEADER_TEXT          =   'Ziyaret Türü'               " The column header label
        FIELD_NAME           =   'ZIYARETTUR'               " The structure component name in the data table structure
        DISPLAY_TYPE         =   IF_SALV_BS_MODEL_COLUMN=>UIE_TEXT_VIEW               " The column display type
  ).
  
    LO_CONFIG->ADD_COLUMN(
      EXPORTING
        HEADER_TEXT          =   'Yapılan iş'               " The column header label
        FIELD_NAME           =   'YAPILANIS'               " The structure component name in the data table structure
        DISPLAY_TYPE         =   IF_SALV_BS_MODEL_COLUMN=>UIE_TEXT_VIEW               " The column display type
  ).
  
    TRY .
        LO_TOOL_XLS->READ_RESULT( IMPORTING CONTENT =   LV_CONTENT ) .
      CATCH
        CX_ROOT INTO DATA(EXCPTION).
    ENDTRY.
  
  
    CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
      EXPORTING
        BUFFER        = LV_CONTENT
      IMPORTING
        OUTPUT_LENGTH = LV_LENGHT
      TABLES
        BINARY_TAB    = LT_BINARY_TAB.
  
    CALL FUNCTION 'GUI_DOWNLOAD'
      EXPORTING
        BIN_FILESIZE = LV_LENGHT
        FILENAME     = 'C:\Users\qwerty\Desktop\Deneme.xlsx'
        FILETYPE     = 'BIN'
      TABLES
        DATA_TAB     = LT_BINARY_TAB.
    IF SY-SUBRC <> 0.
  * Implement suitable error handling here
    ENDIF.
  
  
  
  ENDFORM.