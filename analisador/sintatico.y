/*
Esse é um arquivo feito para o uso no BISON, sendo usado para o trabalho de compiladores.
*/

%{
#include <stdio.h>
int yylex();
int yyerror(char *s) {printf ("\nErro!\n");};
%}

/*  Valor semantico dos simbolos    */
%union {
    int inteiro;
    float real;
    char simbolo;
    char *string_simbolo;
};

/*  Tokens  */
%token <inteiro> INTEIRO
%token <real> REAL
%token <simbolo> ABREPAR FECHAPAR CHAR FIMLINHA ADICAO SUBTRACAO MULTIPLICACAO DIVISAO MAIOR MENOR MAIORIGUAL MENORIGUAL DIFERENTE NEGACAO IGUAL
%token <string_simbolo> TIPOVAR IFCONDICAO ELSECONDICAO FORREPETICAO WHILEREPETICAO FICONDICAO VARIAVEL METODO ATRIBUICAO STRING

/*  Regras da Gramatica */
%start tipoReturn
%%

tipoReturn:
    TIPOVAR METODO {printf ("TipoVar: %s\nNomeMetodo: %s\n", $1, $2);}
    ;
%%

int main (void){
    yyparse();
    return 0;
}
