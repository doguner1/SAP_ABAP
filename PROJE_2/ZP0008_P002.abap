**********************************************************************
* Program     : ZP0008_P0002
* Date        : 04-06-2023
* Developer   : dogukan.guner@dekatre.com
* Contac Num. : 90 507 966 14 06
* Company     : Dekatre Danışmanlık LTD. ŞTİ.

* Change Hist : Change No | Responsible | Date | Descripction
*
****************************DESCRIPTION*********************************
*ALV'den seçilen satırların From görüntüsünü .PDF halinde PC'ye İndirme*
REPORT ZP0008_P026.



INCLUDE ZP0008_P002_TOP.
*INCLUDE ZP0008_P002_TOP. "-> Değişkenlerin tanımlandığı yer
INCLUDE ZP0008_P002_CLS.
*INCLUDE ZP0008_P002_CLS. "-> Sınıfların tanımladığı yer
INCLUDE ZP0008_P002_PBO.
*INCLUDE ZP0008_P002_PBO. "-> Screen için tanımlama yapılan yer(OUTPUT)
INCLUDE ZP0008_P002_PAI.
*INCLUDE ZP0008_P002_PAI. "-> Screen oluşturduktan sonra butonların yakalandığı yer (INPUT)
INCLUDE ZP0008_P002_FRM.
*INCLUDE ZP0008_P002_FRM. "-> Formların yazıldığı yer
"---------------------------------------------------------

START-OF-SELECTION.

  PERFORM GET_DATA.
  PERFORM SET_FCAT.
  PERFORM SET_LAYOUT.


  CALL SCREEN 1000.