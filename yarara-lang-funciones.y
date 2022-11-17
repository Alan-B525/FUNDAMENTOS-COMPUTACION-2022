%{
#include <stdio.h>
#include <string.h>
#include "lex.yy.c"
int yylex (void);
extern FILE * yyin;
void yyerror (char const *);
#include "funciones.h"
#include "funciones.c" /* incluye funciones usadas por el grupo encargado de funciones */
extern int arg ;
%}

%union { 
	char name[32]; /* no me deja usar el LARGO del #define ... */
	int value;
	char typ;
}

%token ID FIN_LINEA PUNTOYCOMA TIPO_DATO TIPO_VOID ABRIR_P CERRAR_P ABRIR_LL CERRAR_LL RETORNO IGUAL
%token LLAMAR COMO DEFINIR
%token ENTERO LONG CARACTER FLOTANTE DOUBLE BOOLEANO PUNTERO

%type<name> ID llamada_funcion_r funcdef_r
%type<typ> TIPO_VOID TIPO_DATO

%left PUNTOYCOMA

%start inicio_s

%%

inicio_s 	:	codigo_r inicio_s
			| 	codigo_r
    		;
    
codigo_r	:	funcdef_r			{ checkFuncDef($1) ; }
			| 	expr_general_r		{ printf("\nEncontro una expresion generica\n") ; }		
          	;

llamada_funcion_r 	: 	LLAMAR ID ABRIR_P parametro_r CERRAR_P FIN_LINEA 	{ strcpy( $$ , $2 ) ; }
					| 	LLAMAR ID valor_r FIN_LINEA							{ strcpy( $$ , $2 ) ; pushArg('d') ; arg = 1; }
      				|	LLAMAR ID ID FIN_LINEA 								{ strcpy( $$ , $2 ) ; pushArg('d') ; arg = 1; }
      				|	LLAMAR ID FIN_LINEA 								{ strcpy( $$ , $2 ) ; arg = 0; }
		  			;

parametro_r : parametro_r PUNTOYCOMA parametro_r 
            | valor_r	{ pushArg('d') ; }
	    	| ID	{ pushArg('d') ; }	/* { pushArg( obtenerTipo($1) ) ; } capas algo asi... */
            ;

funcdef_r 	: 	DEFINIR	ID COMO TIPO_DATO ABRIR_P def_arg_pos_r CERRAR_P ABRIR_LL expr_general_r RETORNO expr_retorno_r FIN_LINEA CERRAR_LL 	
		   		{ strcpy( $$ , $2 ) ; } /* CON ARGUMENTOS _ RETORNO */
          	| 	DEFINIR ID COMO TIPO_VOID ABRIR_P def_arg_pos_r CERRAR_P ABRIR_LL expr_general_r CERRAR_LL 										
				{ strcpy( $$ , $2 ) ; } /* CON ARGUMENTOS _ VOID */
			|	DEFINIR	ID COMO TIPO_DATO ABRIR_P CERRAR_P ABRIR_LL expr_general_r RETORNO expr_retorno_r FIN_LINEA CERRAR_LL 				
				{ strcpy( $$ , $2 ) ; arg = 0 ; } /* SIN ARGUMENTOS _ RETORNO */
          	| 	DEFINIR ID COMO TIPO_VOID ABRIR_P CERRAR_P ABRIR_LL expr_general_r CERRAR_LL 												
				{ strcpy( $$ , $2 ) ; arg = 0 ; } /* SIN ARGUMENTOS _ VOID */
          	;
            
def_arg_pos_r	:	def_arg_pos_r PUNTOYCOMA def_arg_pos_r
          	| 	TIPO_DATO ID				{ pushArg($1) ; } 	/* agrega a la pila de argumentos temporal */
          	;

def_arg_no_pos_r : PUNTOYCOMA arg_no_pos_r;

arg_no_pos_r : def_arg_pos_r PUNTOYCOMA def_arg_pos_r
          	| 	TIPO_DATO ID IGUAL valor_r 	{ pushArg($1) ; }
		;

valor_r		: 	ENTERO
           	| 	FLOTANTE	
           	| 	LONG
           	| 	DOUBLE
           	| 	PUNTERO
           	| 	CARACTER
           	| 	BOOLEANO
           	;

expr_retorno_r	:	ID
				|	valor_r
                | 	ABRIR_P expr_retorno_r CERRAR_P
                ; 

expr_general_r	:	ID /*{ printf("\n Encontro el identificador: %s \n",$1); }*/
				|	llamada_funcion_r	{ checkLlamada($1) ; }
				;

%%

void yyerror(const char *msg){
    fprintf(stderr, "%s\n", msg);
}

int main(int argc, char *argv[]){
	/* Para recibir un archivo como parametro. */
	++argv, --argc;
	if (argc > 0)
   		yyin = fopen(argv[0], "r");
	else
   		yyin = stdin;
		
	int result = yyparse();
	liberar(); 	/* liberar memoria de las listas */
	fclose(yyin);
	return result ;
}
