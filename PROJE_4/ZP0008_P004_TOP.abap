*&---------------------------------------------------------------------*
*&  Include           ZP0008_P004_TOP
*&---------------------------------------------------------------------*

DATA: GO_ALV  TYPE REF TO CL_GUI_ALV_GRID,
      GO_CONT TYPE REF TO CL_GUI_CUSTOM_CONTAINER.

DATA: GT_SCARR         TYPE TABLE OF SCARR,
      GT_SCARR2        TYPE TABLE OF SCARR,

      GT_FCAT          TYPE LVC_T_FCAT,
      GS_FCAT          TYPE LVC_S_FCAT,
      GS_LAYOUT        TYPE LVC_S_LAYO,
      GT_SELECTED_ROWS TYPE TABLE OF LVC_T_ROW.

DATA: IT_SELECTED_ROWS TYPE LVC_T_ROW. "To get Selected rows from ALV.
DATA: LS_SELECTED_ROW LIKE LINE OF IT_SELECTED_ROWS.

DATA: GV_FM_NAME    TYPE RS38L_FNAM,
      GS_CONTROLS   TYPE SSFCTRLOP,
      GS_OUTPUT_OPT TYPE SSFCOMPOP.

DATA: go_spli TYPE REF TO CL_GUI_SPLITTER_CONTAINER,
      go_sub1 type REF TO CL_GUI_CONTAINER,
      go_sub2 type REF TO CL_GUI_CONTAINER.

DATA: go_docu TYPE REF TO CL_DD_DOCUMENT.

CLASS CL_EVENT_RECEIVER DEFINITION DEFERRED. "Böyle bir sınıfım var
"Bu yüzden altaki alan sınfımı göremediği vakit kızmayacak
"Bu genelde kod satırların sıralamasında olabilecek kısa hatalardır
DATA: GO_EVENT_RECEIVER TYPE REF TO CL_EVENT_RECEIVER.


DATA:
  LR_EXCEL_STRUCTURE      TYPE REF TO DATA,
  LO_SOURCE_TABLE_DESCR   TYPE REF TO CL_ABAP_TABLEDESCR,
  LO_TABLE_ROW_DESCRIPTOR TYPE REF TO CL_ABAP_STRUCTDESCR,
  LV_CONTENT              TYPE XSTRING,
  LT_BINARY_TAB           TYPE TABLE OF SDOKCNTASC,
  LV_LENGHT               TYPE I,
  LV_FIELNAME             TYPE STRING,
  LV_PATH                 TYPE STRING,
  LV_FULLPATH            TYPE STRING.