*&---------------------------------------------------------------------*
*&  Include           ZP0008_P003_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  SAVEDATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SAVEDATA .

    P_CURR = 'TRY'.
    P_FILLER = SPACE.
    P_LANGU = SY-LANGU.
    P_AMOUNT = GV_MIKTAR.
  
    CALL FUNCTION 'SPELL_AMOUNT'
      EXPORTING
        AMOUNT    = P_AMOUNT
        CURRENCY  = P_CURR
        FILLER    = P_FILLER
        LANGUAGE  = P_LANGU
      IMPORTING
        IN_WORDS  = WS_SPELL
      EXCEPTIONS
        NOT_FOUND = 1
        TOO_LARGE = 2
        OTHERS    = 3.
    IF SY-SUBRC <> 0.
      MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
      WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ELSE.
      CONCATENATE '#' WS_SPELL-WORD '#'
      INTO GV_TL_ST
      SEPARATED BY SPACE.
    ENDIF.
  
    GS_LOG-ADI = GV_AD.
    GS_LOG-SOYADI = GV_SYD.
    GS_LOG-IL = GV_IL.
    GS_LOG-MIKTAR = GV_MIKTAR.
    GS_LOG-TC = GV_TC.
    GS_LOG-MIKTARST = GV_TL_ST.
  
    INSERT GS_LOG INTO TABLE GT_LOG.
    COMMIT WORK AND WAIT.
  
  
  
  
    DATA:
     LV_BIN_FILESIZE TYPE I.
  
    DATA: ITOTF    TYPE STANDARD TABLE OF ITCOO,
          IT_TLINE TYPE STANDARD TABLE OF TLINE.
  
  
    CALL FUNCTION '/1BCDWB/SF00000011'
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
        IT_LOG             = GT_LOG
      IMPORTING
  *     DOCUMENT_OUTPUT_INFO       =
        JOB_OUTPUT_INFO    = JOB_OUTPUT_INFO
  *     JOB_OUTPUT_OPTIONS =
  *   EXCEPTIONS
  *     FORMATTING_ERROR   = 1
  *     INTERNAL_ERROR     = 2
  *     SEND_ERROR         = 3
  *     USER_CANCELED      = 4
  *     OTHERS             = 5
      .
    IF SY-SUBRC <> 0.
  * Implement suitable error handling here
    ENDIF.
  
    ITOTF = JOB_OUTPUT_INFO-OTFDATA.
  
    CALL FUNCTION 'CONVERT_OTF'
      EXPORTING
        FORMAT                = 'PDF'
  *     MAX_LINEWIDTH         = 132
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
  
    LV_FILENAME = GV_AD.
    CONCATENATE LV_DIRECTORY LV_FILENAME LV_EXTENSION INTO LV_FULLPATH.
  
    CALL FUNCTION 'GUI_DOWNLOAD'
      EXPORTING
        BIN_FILESIZE            = LV_BIN_FILESIZE
        FILENAME                = LV_FULLPATH
        FILETYPE                = 'BIN'
  *     APPEND                  = ' '
  *     WRITE_FIELD_SEPARATOR   = ' '
  *     HEADER                  = '00'
  *     TRUNC_TRAILING_BLANKS   = ' '
  *     WRITE_LF                = 'X'
  *     COL_SELECT              = ' '
  *     COL_SELECT_MASK         = ' '
  *     DAT_MODE                = ' '
  *     CONFIRM_OVERWRITE       = ' '
  *     NO_AUTH_CHECK           = ' '
  *     CODEPAGE                = ' '
  *     IGNORE_CERR             = ABAP_TRUE
  *     REPLACEMENT             = '#'
  *     WRITE_BOM               = ' '
  *     TRUNC_TRAILING_BLANKS_EOL       = 'X'
  *     WK1_N_FORMAT            = ' '
  *     WK1_N_SIZE              = ' '
  *     WK1_T_FORMAT            = ' '
  *     WK1_T_SIZE              = ' '
  *     WRITE_LF_AFTER_LAST_LINE        = ABAP_TRUE
  *     SHOW_TRANSFER_STATUS    = ABAP_TRUE
  *     VIRUS_SCAN_PROFILE      = '/SCET/GUI_DOWNLOAD'
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
  
  
  
  
  *  INSERT ZP0008_T0001 FROM GS_LOG.
  *  COMMIT WORK AND WAIT.
  
  ENDFORM.