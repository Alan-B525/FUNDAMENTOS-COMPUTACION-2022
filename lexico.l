%{
	/*Definition section */
    #include<stdlib.h>
    #include "parser.tab.h" 
	void showError();
%}

/* Rule: 
*/
nombre_variable ([a-zA-Z0-9])+

%%
"FILE"      {yylval.tipo_dato_archivo = yytext; return (TIPO_DATO_ARCHIVO);}

"fopen"      {yylval.funcion_archivo_fopen = yytext; return (FUNCION_ARCHIVO_FOPEN);}
"fscanf"    {yylval.funcion_archivo_fscanf = yytext; return (FUNCION_ARCHIVO_FSCANF);}
"fprintf"    {yylval.funcion_archivo_fprintf = yytext; return (FUNCION_ARCHIVO_FPRINTF);}
"fclose"      {yylval.funcion_archivo_fclose = yytext; return (FUNCION_ARCHIVO_FCLOSE);}

{nombre_variable} {sscanf(yytext,"%s",yylval.nombre_variable); return (NOMBRE_VARIABLE);}

"("             {return (LEFTP);}
")"             {return (RIGHTP);}
";"         {return(PUNTOCOMA);}
"="              {return (EQUALS);}
"*"         {return (PUNTERO);}
[ \t\n]     {}
.                 {showError(); return (OTHER);}

%%

int yywrap(){}

void showError(char* other){
    printf("\n <<ErrorLexico: \"%s\" >>",other);
}
