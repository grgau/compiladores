/*
Esse é um arquivo feito para o uso no BISON, sendo usado para o trabalho de compiladores.
*/

%{
#include <stdio.h>
int yylex();
int yyerror(char *s) {printf ("\nErro! %s\n", s);};
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
%token <simbolo> OUTROARGUMENTO BLOCO FIMBLOCO ABREPAR FECHAPAR CHAR FIMLINHA ADICAO SUBTRACAO MULTIPLICACAO DIVISAO MAIOR MENOR MAIORIGUAL MENORIGUAL DIFERENTE NEGACAO IGUAL
%token <string_simbolo> TIPOVAR IFCONDICAO ELSECONDICAO FORREPETICAO WHILEREPETICAO VARIAVEL METODO ATRIBUICAO STRING

/*  Regras da Gramatica */
%start Funcao
%%

Funcao:
    TIPOVAR METODO ABREPAR MaisDeUmArgumento FECHAPAR BLOCO //{printf ("%s\n %s\n %c\n", $1, $2, $3);}
    Interior
    FIMBLOCO
    ;

Interior:
    /* Vazio */
    | Partes Interior
    ;

Partes:
    TIPOVAR MaisDeUmArgumento FIMLINHA
    | VARIAVEL ATRIBUICAO INTEIRO FIMLINHA
    | VARIAVEL ATRIBUICAO REAL FIMLINHA
    | VARIAVEL ATRIBUICAO CHAR FIMLINHA
    | VARIAVEL ATRIBUICAO VARIAVEL FIMLINHA
    | VARIAVEL ATRIBUICAO OperacaoAritmetica FIMLINHA
    | METODO ABREPAR MaisDeUmArgumento FECHAPAR FIMLINHA
    | OperacaoComparacao FIMLINHA
    | Condicao

MaisDeUmArgumento:
    VARIAVEL OUTROARGUMENTO MaisDeUmArgumento //{printf ("%s\n %c\n", $1, $2);}
    | VARIAVEL //{printf ("%s\n", $1);}
    ;

OperacaoAritmetica:
    VARIAVEL ADICAO VARIAVEL
    | VARIAVEL SUBTRACAO VARIAVEL
    | VARIAVEL MULTIPLICACAO VARIAVEL
    | VARIAVEL DIVISAO VARIAVEL
    ;

OperacaoComparacao:
    VARIAVEL MAIOR VARIAVEL
    | VARIAVEL MENOR VARIAVEL
    | VARIAVEL MAIORIGUAL VARIAVEL
    | VARIAVEL MENORIGUAL VARIAVEL
    | VARIAVEL DIFERENTE VARIAVEL
    | VARIAVEL IGUAL VARIAVEL
    | NEGACAO VARIAVEL
    ;

Condicao:
    IFCONDICAO ABREPAR OperacaoComparacao FECHAPAR BLOCO Interior FIMBLOCO Else
    | FORREPETICAO
    | WHILEREPETICAO ABREPAR OperacaoComparacao FECHAPAR BLOCO Interior FIMBLOCO
    ;

Else:
    /* Vazio */
    | ELSECONDICAO BLOCO Interior FIMBLOCO
    ;

%%

int main (void) {
    yyparse();
    return 0;
}
