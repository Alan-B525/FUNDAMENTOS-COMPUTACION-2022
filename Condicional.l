%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
char *temp;
%}

identificador [a-z][a-z|A-Z|0-9|_]*
numero_entero [-]?[0-9]+
numero_flotante [-]?[0-9]+[.][0-9]+[f]?

%%
"si"					{ return SI; }
"sino"				{ return SINO; }
"entonces"			{ return ENTONCES; }
"finsi"				{ return FINSI; }
"segun"				{ return SEGUN; }
"finsegun"			{ return FIN_SEGUN; }
"caso"				{ return CASO; }
"fincaso"			{ return FIN_CASO; }
"pordefecto"			{ return POR_DEFECTO; }
"("					{ return PI; }
")"					{ return PD; }
"{"					{ return CI; }
"}"					{ return CD; }
":"					{ return DOSPUNTOS; }
{identificador}		{ temp = malloc(sizeof(char)*(strlen(yytext)+1));
					 strcpy(temp,yytext);
					 return(VARIABLE);}
{numero_entero}		{ yylval.numero_entero = atoi(yytext); return NUMERO_ENTERO;}
{numero_flotante}	{ yylval.numero_flotante = atof(yytext); return NUMERO_FLOTANTE;}
"<"					{ return MENOR; }
"<="					{ return MENOR_IGUAL; }
">="					{ return MAYOR_IGUAL; }
">"					{ return MAYOR; }
"=="					{ return IGUAL; }
"!="					{ return DISTINTO; }
\n					/* Ignora los fines de linea. */;
[ \t]+					/* Ignora los espacios en blanco. */;
%%

int yywrap()
{
	return 1;
}