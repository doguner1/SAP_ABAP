**********************************************************************
* Program     : ZP0008_P0003
* Date        : 05-06-2023
* Developer   : dogukan.guner@dekatre.com
* Contac Num. : 90 507 966 14 06
* Company     : Dekatre Danışmanlık LTD. ŞTİ.

* Change Hist : Change No | Responsible | Date | Descripction
*
****************************DESCRIPTION*********************************
*Girilen Bilgilere Göre Çek Doldurma, PDF olarak indirme ve Veri Tabanına Kaydetme*
REPORT ZP0008_P027.

INCLUDE ZP0008_P027_TOP.
*INCLUDE ZP0008_P027_TOP. "-> Değişkenlerin tanımlandığı yer
***INCLUDE ZP0008_P027_CLS.
****INCLUDE ZP0008_P027_CLS. "-> Sınıfların tanımladığı yer
INCLUDE ZP0008_P027_PBO.
*INCLUDE ZP0008_P027_PBO. "-> Screen için tanımlama yapılan yer(OUTPUT)
INCLUDE ZP0008_P027_PAI.
*INCLUDE ZP0008_P027_PAI. "-> Screen oluşturduktan sonra butonların yakalandığı yer (INPUT)
INCLUDE ZP0008_P027_FRM.
*INCLUDE ZP0008_P027_FRM. "-> Formların yazıldığı yer
"---------------------------------------------------------


START-OF-SELECTION.

call SCREEN 1000.