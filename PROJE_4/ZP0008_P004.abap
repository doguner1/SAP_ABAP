REPORT ZP0008_P030.



INCLUDE ZP0008_P030_TOP.
*INCLUDE ZP0008_P024_TOP.
*INCLUDE ZP0008_P024_TOP. "-> Değişkenlerin tanımlandığı yer
INCLUDE ZP0008_P030_CLS.
*INCLUDE ZP0008_P024_CLS.
**********************************************************************
* Program     : ZP0008_P0004
* Date        : 08-06-2023
* Developer   : dogukan.guner@dekatre.com
* Contac Num. : 90 507 966 14 06
* Company     : Dekatre Danışmanlık LTD. ŞTİ.

* Change Hist : Change No | Responsible | Date | Descripction
*
*********************************DESCRIPTION***************************************
*ALV den seçilen SCARR tablosundaki satırları tercihe göre EXCEL'e ve FORM'a basma*
REPORT ZP0008_P030.

INCLUDE ZP0008_P004_TOP.
*INCLUDE ZP0008_P004_TOP. "-> Değişkenlerin tanımlandığı yer
INCLUDE ZP0008_P004_CLS.
*INCLUDE ZP0008_P004_CLS. "-> Sınıfların tanımladığı yer
INCLUDE ZP0008_P004_PBO.
*INCLUDE ZP0008_P004_PBO. "-> Screen için tanımlama yapılan yer(OUTPUT)
INCLUDE ZP0008_P004_PAI.
*INCLUDE ZP0008_P004_PAI. "-> Screen oluşturduktan sonra butonların yakalandığı yer (INPUT)
INCLUDE ZP0008_P004_FRM.
*INCLUDE ZP0008_P004_FRM. "-> Formların yazıldığı yer
"---------------------------------------------------------

START-OF-SELECTION.

  PERFORM GET_DATA.
  PERFORM SET_FCAT.
  PERFORM SET_LAYOUT.


  CALL SCREEN 1000.