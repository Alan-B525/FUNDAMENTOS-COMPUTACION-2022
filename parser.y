%{
    /* 1) Bloque: Cabecera codigo C */

    #include <stdio.h>
    int yylex();
    int yyerror(char *s);

    /* 2) Bloque: Tokens */
%}

%token TIPO_DATO_ARCHIVO FUNCION_ARCHIVO_FOPEN FUNCION_ARCHIVO_FSCANF FUNCION_ARCHIVO_FPRINTF FUNCION_ARCHIVO_FCLOSE NOMBRE_VARIABLE LEFTP RIGHTP PUNTOCOMA EQUALS PUNTERO OTHER

%type <tipo_dato_archivo> TIPO_DATO_ARCHIVO
%type <funcion_archivo_fopen> FUNCION_ARCHIVO_FOPEN
%type <funcion_archivo_fscanf> FUNCION_ARCHIVO_FSCANF
%type <funcion_archivo_fprintf> FUNCION_ARCHIVO_FPRINTF
%type <funcion_archivo_fclose> FUNCION_ARCHIVO_FCLOSE
%type <nombre_variable> NOMBRE_VARIABLE

%union{
    char *tipo_dato_archivo;
    char *funcion_archivo_fopen;
    char *funcion_archivo_fscanf;
    char *funcion_archivo_fprintf;
    char *funcion_archivo_fclose;

    char nombre_variable[20];
}

%%
/* secuencia de ejecucion*/

prog:
    INSTRUCCIONES
;

INSTRUCCIONES: /* empty */
            |   INSTRUCCION INSTRUCCIONES
;

INSTRUCCION:    DECLARACION
            |   FUNCIONES
;

DECLARACION: TIPOS_DATOS_ARCHIVOS PUNTERO NOMBRE_VARIABLE PUNTOCOMA 
;

TIPOS_DATOS_ARCHIVOS:   TIPO_DATO_ARCHIVO {printf("(tipo de dato archivo): \"%s\"\n",$1 );}
;

FUNCIONES: FUNCION LEFTP RIGHTP PUNTOCOMA
;

FUNCION:        FUNCION_ARCHIVO_FOPEN {printf("(tipo de dato archivo): \"%s\"\n",$1 );}
            |   FUNCION_ARCHIVO_FSCANF {printf("(tipo de dato archivo): \"%s\"\n",$1 );}
            |   FUNCION_ARCHIVO_FPRINTF {printf("(tipo de dato archivo): \"%s\"\n",$1 );}
            |   FUNCION_ARCHIVO_FCLOSE {printf("(tipo de dato archivo): \"%s\"\n",$1 );}
            |   OTHER
;
%%

int yyerror(char *s){
	printf(" ->Error Sintactico %s\n",s);
}

int main(int argc,char **argv){
	yyparse();
	return 0;
}
