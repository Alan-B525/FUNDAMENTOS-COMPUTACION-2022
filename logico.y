%{
#include <stdio.h>
#include <string.h>
void yyerror(const char *str)
{
fprintf(stderr,"%s\n",str);
}
int yywrap()
{
return 1;
}
main()
{
yyparse();
}
%}
%token NUMERO OR AND NOT NAND XOR SEPARADOR_I SEPARADOR_D NUMERO_E PALABRA
%%
lineas: lineas linea
|
;
input: input erro
|
;
linea: linea
'\n'
| expr 
	{ printf("Salida = %d\n", $$);}
;
input: erro
'\n'
| error
	{
          printf(" Reenter last line: " );
         }
         input
       {
         $$ = $1;
       }
       ;
error:
| NUMERO_E
	{
	yyerrok;
	}
| PALABRA
	{
	yyerrok;
	}
;
expr:
| NUMERO OR NUMERO
	{ 
	if( $1==1 || $3==1){
	$$=1;}
	else{$$=0;}
	}
| NUMERO AND NUMERO     
	{ 
	$$ = $1 * $3;
	}
| NOT NUMERO            
	{ 
	if( $2 == 1){
	$$=0; }else{ $$=1;} 
	} 
| NUMERO NAND NUMERO    
	{ 
	if( $1 * $3 == 1){
	$$=0;}else{$$=1;}
	}
| NUMERO XOR NUMERO     
	{ 
	if( $1==0 && $3==1 || $1==1 && $3==0){
	$$=1; }else{$$=0 ;}
	}
| SEPARADOR_I NUMERO AND NUMERO SEPARADOR_D OR SEPARADOR_I NUMERO AND NUMERO SEPARADOR_D
	{
	if($2*$4==0 && $8*$10==0){
	$$=0;}
	else{$$=1;}
	}
| SEPARADOR_I NUMERO OR NUMERO SEPARADOR_D OR SEPARADOR_I NUMERO OR NUMERO SEPARADOR_D
	{
	if(($2==1 || $4==1) || ($8==1 || $10==1)){
	$$=1;}else{$$=0;}
	}
| SEPARADOR_I NUMERO AND NUMERO SEPARADOR_D AND SEPARADOR_I NUMERO AND NUMERO SEPARADOR_D
	{
	if(($2*$4==0) && $8*$10==0){
	$$=1;}else{$$=0;}
	}
| SEPARADOR_I NUMERO OR NUMERO SEPARADOR_D AND SEPARADOR_I NUMERO OR NUMERO SEPARADOR_D
	{
	if(($2==1 || $4==1) && ($8==1 || $10==1)){
	$$=1;}else{$$=0;}
	}
;
%%