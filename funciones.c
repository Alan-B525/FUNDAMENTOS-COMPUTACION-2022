#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "funciones.h"

/* 
   El diseño de esta estructura deveria corresponder 
   con el de una variable si queremos que tome valores por defecto.
   ademas el uso de valores por defecto permite que la cantidad de argumentos
   de una llamada varie, y eso me da dolor de cabeza.
*/

struct nodoArg {
	//char name[LARGO];	/* Nombre de la variable */
	char typ;			/* Tipo de la variable */
	/*
	union val {			// Valor de la variable
		int entero;
		double real;
	};
	*/
	struct nodoArg * sig;
};

struct nodoFunc {
    char name[LARGO];
    int cantidadArg;
	struct nodoArg * arg;
    struct nodoFunc * sig;
};

struct nodoFunc * raizFunc = NULL;
struct nodoArg * raizArg = NULL; 	//Almacena argumentos de forma temporal.
int arg = 0 ;

int
exists(char * name, int isLlamada) // isLlamada = 1 para llamada.
{
	if(raizFunc == NULL) 
		return 0;
	struct nodoFunc * aux = raizFunc;
	while (aux != NULL)
	{
		if( strcmp( aux->name , name ) == 0 ) 
		{
			if ( isLlamada == 1 ) 
			{
				if ( aux->cantidadArg == arg ) 
					return 1 ;
				else
				{ 
					printf("%s",AMARILLO);
					printf("\nCantidad de argumentos de la funcion %s es %d, se la intento llamar con %d argumentos.\n",aux->name , aux->cantidadArg , arg) ;
					printf("%s",NO_COLOR);
					return 2 ;
				}
			}
			else
				return 1;
		}
		aux = aux->sig;
	}
	return 0;
}

void
pushFunc(char * name)
{
    struct nodoFunc *nuevo;
    nuevo = malloc(sizeof(struct nodoFunc));
    strcpy( nuevo->name , name );
	// Se le asigna a la nueva funcion los argumentos guardados.
	nuevo->arg = raizArg ;
	nuevo->cantidadArg = arg;
	// Ahora la pila de argumentos regresa a cero.
	raizArg = NULL;
    if (raizFunc == NULL)
    {
        raizFunc = nuevo;
        nuevo->sig = NULL;
    }
    else
    {
        nuevo->sig = raizFunc;
        raizFunc = nuevo;
    }
}

void
pushArg(char tipo) // ( char tipo , union val * valor , char * name )
{
	arg++ ;
	struct nodoArg * nuevo;
    nuevo = malloc( sizeof( struct nodoArg ) );
    nuevo->typ = tipo ;
    if (raizArg == NULL)
    {
        raizArg = nuevo;
        nuevo->sig = NULL;
	arg = 1 ;
    }
    else
    {
        nuevo->sig = raizArg ;
        raizArg = nuevo;
    }
}

//char * 
//pop()
//{
    //if (raizFunc != NULL)
    //{
        //char * name = malloc( LARGO ) ;
		//strcpy(name,raizFunc->name);
        //struct nodoFunc *bor = raizFunc;
        //raizFunc = raizFunc->sig;
        //free(bor);
        //return name;
    //}
	//return NULL;
//}

void
liberarArg( struct nodoArg * arg ){
	struct nodoArg * reco = arg ;
	struct nodoArg * bor ;
	while ( reco != NULL )
	{
		bor = reco ;
		reco = reco->sig ;
		free(bor) ;
	}
}

void
liberar()
{
    struct nodoFunc * reco = raizFunc;	/*reco -> recorre*/
    struct nodoFunc * bor;				/*bor -> borra*/
    while (reco != NULL)
    {
        bor = reco;
        reco = reco->sig;
		// Libera la pila de argumentos de la funcion.
		liberarArg( bor->arg ) ;
		// Libera la funcion.
        free(bor);
    }
}

void
checkFuncDef(char * name)
{ 
  if ( ! exists( name , 0) ){

	printf("%s",VERDE);
  	printf("\nEncontro una definicion de funcion (nombre: %s) \n",name);
	printf("%s",NO_COLOR);

    pushFunc(name);
  }
  else{

	printf("%s",ROJO);
  	printf("\nla funcion %s ya existe\n",name);
	printf("%s",NO_COLOR);

	// Definicion de funcion fallo, quitar argumentos acumulados.
	liberarArg( raizArg ) ;
	raizArg = NULL ;
	arg = 0 ;
  }
}

void
checkLlamada(char * name)
{ 
	int result = 0 ;
	result = exists( name , 1) ;
  if ( result == 1 ){

	printf("%s",VERDE);
  	printf("\nEncontro una llamada a la funcion %s con %d argumentos.\n",name,arg);
	printf("%s",NO_COLOR);
  }
  else{

	printf("%s",ROJO);
	if ( result == 2 )
		printf("\nCantidad incorrecta de argumentos. \n");
	else
  		printf("\nLa funcion %s no fue declarada \n",name);
	printf("%s",NO_COLOR);

  }
	arg = 0 ;
	liberarArg(raizArg) ;
	raizArg = NULL ;
}
