*&---------------------------------------------------------------------*
*&  Include           ZP0008_P003_TOP
*&---------------------------------------------------------------------*

DATA:
  GV_AD     TYPE CHAR30,
  GV_SYD    TYPE CHAR30,
  GV_MIKTAR TYPE INT4,
  GV_IL     TYPE CHAR20,
  GV_TC     TYPE CHAR11,
  GV_TL_ST  TYPE STRING.
DATA:
  P_LANGU     LIKE T002-SPRAS,
  P_CURR      LIKE TCURC-WAERS,
  P_AMOUNT    LIKE VBAP-MWSBP,
  P_FILLER(1) TYPE C.

DATA: WS_SPELL TYPE SPELL.

DATA GS_LOG TYPE ZP0008_T0009.
DATA GT_LOG TYPE TABLE OF ZP0008_T0009.

DATA: GV_FM_NAME      TYPE RS38L_FNAM,
      GS_CONTROLS     TYPE SSFCTRLOP,
      GS_OUTPUT_OPT   TYPE SSFCOMPOP,
      JOB_OUTPUT_INFO TYPE SSFCRESCL.

GS_CONTROLS-NO_DIALOG = 'X'.
GS_CONTROLS-PREVIEW = ABAP_TRUE.
GS_CONTROLS-GETOTF = 'X'.
*  Pupop çıktısını kapatık
GS_OUTPUT_OPT-TDDEST = 'LP01'.

DATA: lv_directory TYPE string VALUE 'C:\Users\qwert\Desktop\',
      lv_filename TYPE string,
      lv_extension TYPE string VALUE '.pdf',
      lv_fullpath TYPE string.