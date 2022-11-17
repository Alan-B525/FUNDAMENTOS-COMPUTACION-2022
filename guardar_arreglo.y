%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <ctype.h>
	#include <string.h>
	void yyerror();
	int vec[20];
	int i=0;
%}
%union {
	int numero_entero;
}

%token VECTOR MATRIZ TIPO VARIABLE LI LD CI CD IGUAL SEPARADOR PI PD FOR COMA PRINT
%token <numero_entero> ENTERO
%start programas//indica la constuccion del mas alto nivel 
//reduce todos los elementos de la gramática a una sola regla
%left VECTOR
%left PRINT
/*tipodato mat nombre{DIMENSION1}{DIMENSION2}=[dato1:dato2:dato3,dato4:dato5:dato6]*/
/*tipodato vec nombre{DIMENSION1}=[dato1:dato2:dato3,dato4:dato5:dato6]*/
%% //programa 
programas :/*t*/
	|programa programas 
	|error programas		{fflush(stdin);yyerrok;}
	;
programa:arreglo {printf("\nSintaxis correcta\n\n");};
arreglo	:
	vector
	|
	matriz
	|
	recorrer
	;
vector :
	declarado 
	|
	cargado
	;
declarado : TIPO VECTOR VARIABLE LI dimension LD ;
cargado : VECTOR VARIABLE LI LD IGUAL CI datosvec CD;

matriz:
	declarada
	|
	cargada
	;
declarada : TIPO MATRIZ VARIABLE LI dimension LD LI dimension LD;
cargada : MATRIZ VARIABLE LI LD LI LD IGUAL CI datosmat CD; //[3:5:7,6:9:4]

dimension :ENTERO
	|{printf("\nFalta argumento");}'\t';

datosvec :
	|
	enterovec 
	|
	variablevec
	;
enterovec : ENTERO SEPARADOR enterovec {vec[i]=$1;i++;}
	|ENTERO {vec[i]=$1;i++;}//pag 11 del apunte
	;
variablevec : VARIABLE SEPARADOR variablevec
	|VARIABLE
	;

datosmat :
	|
	enteromat
	|
	variablemat
	;
enteromat : ENTERO SEPARADOR enteromat coma 
	|ENTERO
	;
variablemat : VARIABLE SEPARADOR variablemat coma
	|VARIABLE
	;
coma :	|COMA enteromat
	|COMA variablemat
	;
recorrer : FOR PI PD LI print recorrido LD
	|PRINT VECTOR{int j=i;while(j>0){printf("%d\t",vec[j-1]);j--;}} %prec PRINT
	;

recorrido : VECTOR VARIABLE CI dato CD 
	|MATRIZ VARIABLE CI dato CD CI dato CD
	;
dato : ENTERO|VARIABLE
	;
print : 
	|PRINT;
%%
void yyerror()
{
	printf("\nSintaxis Incorrecta\n\n");
}
main()
{
	yyparse();
	
}