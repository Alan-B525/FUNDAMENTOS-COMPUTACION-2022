# Yarara Lang - Funciones

Gramática y código para implementar funciones en *Yarara Lang*.

## ¿ Que puede hacer el código ?

* Reconocer definiciones de funciones.
* Reconocer llamadas a funciones.
* Recordar una definición de función y evitar que se defina mas de una vez.
* Verificar que la llamada a función sea correcta (parámetros y nombre de la función).

## Palabras reservadas

| Palabra reservada | Equivalente en C | Token usado |
| ---               | ---              | ---         |
| void              | void             | TIPO_VOID   |
| definir           | nada             | DEFINIR     |
| como              | nada             | COMO        |
| hace              | {                | HACE        |
| hecho             | }                | HECHO       |
| .1.               | (                | ABRIR_P     |
| .2.               | )                | CERRAR_P    |
| ;                 | ,                | PUNTOYCOMA  |
| ...               | ;                | FIN_LINEA   |
| :                 | =                | IGUAL       |
