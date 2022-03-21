*&---------------------------------------------------------------------*
*& Report ZYBCOPERACIONES_CADENAS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZYBCOPERACIONES_CADENAS.

DATA: val_longitud(10) TYPE n,
      val_str          TYPE string VALUE 'hola-CEMOSA-ejemplo',
      val_char1(30)    TYPE c,
      val_char2(30)    TYPE c,
      val_char3(30)    TYPE c,
      val_char(30)    TYPE c,
      val_ini TYPE i VALUE 0,
      val_fin TYPE i VALUE 3.


"Dividir cadenas (hola-CEMOSA-ejmplo)
"cada vez que encuentra un guion
"y las guarda en las variables
"                         val_char1 val_char2 val_char3
SPLIT val_str AT '-' INTO val_char1 val_char2 val_char3.


"Asi se guarda el resultado de un SPLIT en una tabla
"Solo especificar:   INTO TABLE <tabla/direccion?>
"SPLIT val_str AT '-' INTO TABLE it_table.


"Aqui se imprime el resultado
WRITE:/ 'char1: ', val_char1.
WRITE:/ 'char2: ', val_char2.
WRITE:/ 'char3: ', val_char3.


"Concatenar val_char1 val_char2 en   val_char y separar con UN ESPACIO
"                                                          space es una variable NO DECLARADA, pero ABAP la tiene predefinida por defecto
CONCATENATE val_char1 val_char2 INTO val_char SEPARATED BY space.
WRITE:/ 'Concatenar: ', val_char.

"Version mas nueva para concatenar
"Funciona desde HANA:
"limpio variable
CLEAR val_char.
"almac.  = conc.     + ','  + conc.
val_char = val_char2 && ',' && val_char3.
"Imprime val_char
WRITE:/ 'Concatenar hana: ', val_char.


"Operacion para obtener la longitud (.length)
"var alm.    = funcion_devuelve_longitud(var_str)
"                    ( <---PARAMETRO-CON-1-ESPACIO-A-LOS-LADOS-OBLIGATORIO---> )
val_longitud = strlen( val_str ).
WRITE:/ 'Longitud: ', val_longitud.


"Subcadenas
"                 +0(3)=> Guardar lo que se encuentre ENTRE LA POSICION 0 y 3
"val_cahr= val_str+val_ini(val_fin). <--Lo mismo pero con variables
val_char = val_str+0(3).
WRITE:/ 'Subcadena: ',val_char.


"Buscar cadenas dentro de otras cadenas
"BUSCA dentro de val_str SI EXISTE val_char2.
SEARCH val_str FOR val_char2.
"Si la encuentra     sy-subrc=0 (EXITOSA)
WRITE:/ 'Exito ?: ', sy-subrc.
"Posicion se almacena sy-fdpos. Al igual que sy-sunrc, estan PREDEFINIDAS en ABAP. Se modifican solas segun avanze el programa.
WRITE:/ 'Posición: ', sy-fdpos.


"Busca dentro de val_str LA PALABRA 'suma'
SEARCH val_str FOR 'suma'.
"NO ENCONTRADO ----> sy-subrc = 4
WRITE:/ 'Exito ?: ', sy-subrc.
"Cambiara a 0  -----> sy-fdpos = 0
WRITE:/ 'Posición: ', sy-fdpos.


"Reemplazar una CADENA o un CARACTER con otra cosa
"Todo
"REEMPLAZA todos los       '-' en val_str con  '*'
REPLACE ALL OCCURRENCES OF '-' IN val_str WITH '*'.
WRITE:/ val_str.


"Solo el primero que encuentre
"REEMPLAZA primer '*'encontrado en val_str con  '.'
REPLACE FIRST OCCURRENCE OF '*' in val_str WITH '.'.
WRITE:/ val_str.