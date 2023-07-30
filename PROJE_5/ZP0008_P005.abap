*&---------------------------------------------------------------------*
*& Report ZP0008_P005
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZP0008_P005.

*
* Yönetici nick + şifre       => d.gunr      /   dodo
* Saha Çalışan nick + şifre   => Ö_ÇELEBI   /    OMERÇ
*


INCLUDE ZP0008_P040_TOP.
INCLUDE ZP0008_P040_CLS.
INCLUDE ZP0008_P040_PBO.
INCLUDE ZP0008_P040_PAI.
INCLUDE ZP0008_P040_FRM.

START-OF-SELECTION.

  SELECT * FROM ZP0008_T0020
  INTO TABLE GT_VISIT.

  PERFORM FCAT.

LOOP AT GT_VISIT INTO GS_VISIT.
  IF GS_VISIT-RAPORID > LV_MAX_RAPORID.
    LV_MAX_RAPORID = GS_VISIT-RAPORID.
  ENDIF.
ENDLOOP.

LV_MAX_RAPORID = LV_MAX_RAPORID + 1.
GV_RAPORID = LV_MAX_RAPORID.


  CALL  SCREEN 1000.