%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <ctype.h>
	#include <string.h>
	void yyerror();
%}

//Delcaraciones Yacc

%union {
    int numero_entero;
    float numero_flotante;
}

%token VARIABLE SI SINO ENTONCES FINSI PI PD CI CD MENOR MENOR_IGUAL MAYOR_IGUAL MAYOR IGUAL DISTINTO
%token SEGUN FIN_SEGUN CASO FIN_CASO POR_DEFECTO DOSPUNTOS
%token<numero_entero> NUMERO_ENTERO
%token<numero_flotante> NUMERO_FLOTANTE
%start programa

%% //Gramatica
programa : 
	sentencias
	|
	error programa				{yyerrok;}
	;

sentencias :
	|
	sentencia sentencias
	;

sentencia :
	condicional					{printf("\t//Sintaxis Condicional Correcta.\n");}
	;

condicional :
	si
	|
	si_sino
	|
	segun
	;

si : SI PI condicion PD ENTONCES bloque_sentencias FINSI
	;

si_sino : SI PI condicion PD ENTONCES bloque_sentencias SINO bloque_sentencias FINSI
	;


segun : SEGUN PI VARIABLE PD ENTONCES casos_segun FIN_SEGUN
	;

casos_segun : 
	CASO NUMERO_ENTERO DOSPUNTOS bloque_sentencias FIN_CASO casos_segun
	|
	POR_DEFECTO DOSPUNTOS bloque_sentencias FIN_CASO
	;


condicion : 
	 NUMERO_ENTERO MENOR NUMERO_ENTERO		
	|NUMERO_ENTERO MENOR_IGUAL NUMERO_ENTERO	
	|NUMERO_ENTERO MAYOR NUMERO_ENTERO		
	|NUMERO_ENTERO MAYOR_IGUAL NUMERO_ENTERO	
	|NUMERO_ENTERO IGUAL NUMERO_ENTERO		
	|NUMERO_ENTERO DISTINTO NUMERO_ENTERO		
	|NUMERO_FLOTANTE MENOR NUMERO_FLOTANTE		
	|NUMERO_FLOTANTE MENOR_IGUAL NUMERO_FLOTANTE	
	|NUMERO_FLOTANTE MAYOR NUMERO_FLOTANTE
	|NUMERO_FLOTANTE MAYOR_IGUAL NUMERO_FLOTANTE	
	|NUMERO_FLOTANTE IGUAL NUMERO_FLOTANTE	
	|NUMERO_FLOTANTE DISTINTO NUMERO_FLOTANTE
	|VARIABLE MENOR VARIABLE		
	|VARIABLE MENOR_IGUAL VARIABLE	
	|VARIABLE MAYOR VARIABLE
	|VARIABLE MAYOR_IGUAL VARIABLE	
	|VARIABLE IGUAL VARIABLE	
	|VARIABLE DISTINTO VARIABLE
	 ;

   bloque_sentencias : 
	CI  sentencias  CD
	;



%% //Codigo C

void yyerror()
{
	printf("\nSintaxis Incorrecta\n\n");
}
main()
{
	yyparse();
}
