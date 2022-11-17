%option noyywrap
%{
#include <stdio.h>
#include <stdio.h>
#include "y.tab.h"
%}
%%
[0-1] {
          yylval = atoi(yytext);
          return NUMERO;
        }
[2-9]+ {
	  yylval = atoi(yytext);
          return NUMERO_E;
	}
[a-z]+ {
	  yylval = atoi(yytext);
          return PALABRA;
	}
"("	return SEPARADOR_I;
")"	return SEPARADOR_D;
"&&"	return AND;
"||"	return OR;
"!="	return NOT;
"!|"	return XOR;
"!&"	return NAND;
\n ;
[ \t]+ ;
%%