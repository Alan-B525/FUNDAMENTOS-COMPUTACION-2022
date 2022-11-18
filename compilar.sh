#!/bin/bash
    clear
echo "<Inicio de Bison y Flex>"
    flex -l lexico.l
    bison -dv parser.y
    gcc -o main parser.tab.c lex.yy.c -lfl
echo "<FIN>"
    ./main <input.txt