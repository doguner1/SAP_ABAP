**********************************************************************
* Program     : ZP0008_P0001
* Date        : 03-06-2023
* Developer   : dogukan.guner@dekatre.com
* Contac Num. : 90 507 966 14 06
* Company     : Dekatre Danışmanlık LTD. ŞTİ.

* Change Hist : Change No | Responsible | Date | Descripction
*
****************************DESCRIPTION*********************************
**ALV Uzerinden Seçilen Tablo Verilerinin SmartForm ile Çıktısını Alma**
REPORT ZP0008_P001.

INCLUDE ZP0008_P001_TOP.
*INCLUDE ZP0008_P001_TOP. "-> Değişkenlerin tanımlandığı yer
INCLUDE ZP0008_P001_CLS.
*INCLUDE ZP0008_P001_CLS. "-> Sınıfların tanımladığı yer
INCLUDE ZP0008_P001_PBO.
*INCLUDE ZP0008_P001_PBO. "-> Screen için tanımlama yapılan yer(OUTPUT)
INCLUDE ZP0008_P001_PAI.
*INCLUDE ZP0008_P001_PAI. "-> Screen oluşturduktan sonra butonların yakalandığı yer (INPUT)
INCLUDE ZP0008_P001_FRM.
*INCLUDE ZP0008_P001_FRM. "-> Formların yazıldığı yer
"---------------------------------------------------------

START-OF-SELECTION.

  PERFORM GET_DATA.
  PERFORM SET_FCAT.
  PERFORM SET_LAYOUT.


  CALL SCREEN 1000.