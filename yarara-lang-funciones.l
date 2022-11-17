%{
#include "yarara-lang-funciones.tab.h"
extern YYSTYPE yylval;
%}
/*Definiciones*/

NUM		[0-9]
ID		[a-zA-Z]("_"|[a-zA-Z0-9])*

/*Reglas:*/
%%
		
{NUM}+ 			{ yylval.value = atoi( yytext ); return ENTERO ; }
void 			{ yylval.typ = '\0' ; return TIPO_VOID ;	}
dato 			{ yylval.typ = 'd' ; return TIPO_DATO ;	}
: 				{ return IGUAL ;		}
; 				{ return PUNTOYCOMA ;  	}
"."1"." 		{ return ABRIR_P ; 		}
"."2"." 		{ return CERRAR_P ; 	}
hace 			{ return ABRIR_LL ; 	}
hecho 			{ return CERRAR_LL ; 	}
retorna 		{ return RETORNO ; 		}
llamar 			{ return LLAMAR ; 		}
como 			{ return COMO ; 		}
definir 		{ return DEFINIR ; 		}
"."".""."		{ return FIN_LINEA ; 	}
{ID}			{ strcpy( yylval.name , yytext ); return ID ; 	}

[ \t\n]+        	/* Sacar espacios en blanco */
. 				{ printf("\033[0;31m Cadena: %s \t\t  detecto un caracter invalido\n",yytext);	}
<<EOF>>			{ return 0; }

%%
