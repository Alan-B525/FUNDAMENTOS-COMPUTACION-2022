%{
#include<stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
char *temp;
%}

/*tipo mat nombre{DIMENSION1}{DIMENSION2}=[dato1:dato2:dato3,dato4:dato5:dato6]*/
/*matriz 2*3(filas*columnas)*/

numero_entero [-]?[0-9]+
identificador [a-z][a-z|A-Z|0-9|_]*
%%
"vec" {return VECTOR; }
"mat" {return MATRIZ; }
"int" {return TIPO; }
"float"	{return TIPO; }
"for" {return FOR;}
"strings" {return TIPO; }
"print" {return PRINT; }
{identificador}		{ temp = malloc(sizeof(char)*(strlen(yytext)+1));
					 strcpy(temp,yytext);
					 return(VARIABLE);}
"{"	{return LI; }
"}"	{return LD; }
"["	{return CI; }
"]"	{return CD; }
"("	{return PI; }
")"	{return PD; }
"="	{return IGUAL; }
":"	{return SEPARADOR; }
","	{return COMA; }
{numero_entero}		{ yylval.numero_entero = atoi(yytext); return ENTERO;}
[\n\t]+ ;
%%
int yywrap()
{
	return 1;
}
