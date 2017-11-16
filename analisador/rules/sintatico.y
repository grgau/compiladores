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
%token <simbolo> VIRGULA BLOCO FIMBLOCO ABREPAR FECHAPAR CHAR FIMLINHA ADICAO SUBTRACAO MULTIPLICACAO DIVISAO MAIOR MENOR MAIORIGUAL MENORIGUAL DIFERENTE NEGACAO IGUAL
%token <string_simbolo> TIPOVAR IFCONDICAO ELSECONDICAO FORREPETICAO WHILEREPETICAO VARIAVEL METODO ATRIBUICAO STRING

/*  Regras da Gramatica */
%start Funcao
%%

Funcao:
    TIPOVAR METODO ABREPAR MaisDeUmArgumento FECHAPAR BLOCO Interior FIMBLOCO
    ;

Interior:
    /* Cadeia vazia */
    | Partes Interior
    ;

Partes:
    TIPOVAR MaisDeUmArgumento FIMLINHA
    | VARIAVEL ATRIBUICAO INTEIRO FIMLINHA
    | VARIAVEL ATRIBUICAO REAL FIMLINHA
    | VARIAVEL ATRIBUICAO CHAR FIMLINHA
    | VARIAVEL ATRIBUICAO VARIAVEL FIMLINHA
    | VARIAVEL ATRIBUICAO OperacaoAritmetica FIMLINHA
    | VARIAVEL ATRIBUICAO OperacaoAritmeticaInt FIMLINHA
    | VARIAVEL ATRIBUICAO OperacaoAritmeticaFloat FIMLINHA
    | METODO ABREPAR MaisDeUmArgumento FECHAPAR FIMLINHA
    | Condicao

MaisDeUmArgumento:
    /* Cadeia vazia */
    VARIAVEL VIRGULA MaisDeUmArgumento //{printf ("%s\n %c\n", $1, $2);}
    | VARIAVEL //{printf ("%s\n", $1);}
    ;

OperacaoAritmetica:
    VARIAVEL ADICAO VARIAVEL
    | VARIAVEL SUBTRACAO VARIAVEL
    | VARIAVEL MULTIPLICACAO VARIAVEL
    | VARIAVEL DIVISAO VARIAVEL
    ;

OperacaoAritmeticaInt:
    VARIAVEL ADICAO INTEIRO
    | VARIAVEL SUBTRACAO VARIAVEL
    | VARIAVEL MULTIPLICACAO INTEIRO
    | VARIAVEL DIVISAO INTEIRO
    ;

OperacaoAritmeticaFloat:
    VARIAVEL ADICAO REAL
    | VARIAVEL SUBTRACAO REAL
    | VARIAVEL MULTIPLICACAO REAL
    | VARIAVEL DIVISAO REAL
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

OperacaoComparacaoInt:
    VARIAVEL MAIOR INTEIRO
    | VARIAVEL MENOR INTEIRO
    | VARIAVEL MAIORIGUAL INTEIRO
    | VARIAVEL MENORIGUAL INTEIRO
    | VARIAVEL DIFERENTE INTEIRO
    | VARIAVEL IGUAL INTEIRO
    ;

OperacaoComparacaoFloat:
    VARIAVEL MAIOR REAL
    | VARIAVEL MENOR REAL
    | VARIAVEL MAIORIGUAL REAL
    | VARIAVEL MENORIGUAL REAL
    | VARIAVEL DIFERENTE REAL
    | VARIAVEL IGUAL REAL
    ;

OperacaoComparacaoChar:
    VARIAVEL DIFERENTE CHAR
    | VARIAVEL IGUAL CHAR
    ;

Condicao:
    IFCONDICAO ABREPAR OperacaoComparacao FECHAPAR BLOCO Interior FIMBLOCO Else
    | IFCONDICAO ABREPAR OperacaoComparacaoInt FECHAPAR BLOCO Interior FIMBLOCO Else
    | IFCONDICAO ABREPAR OperacaoComparacaoFloat FECHAPAR BLOCO Interior FIMBLOCO Else
    | IFCONDICAO ABREPAR OperacaoComparacaoChar FECHAPAR BLOCO Interior FIMBLOCO Else
    | FORREPETICAO ABREPAR VARIAVEL ATRIBUICAO INTEIRO VIRGULA OperacaoComparacaoInt VIRGULA VARIAVEL ATRIBUICAO OperacaoAritmeticaInt FECHAPAR BLOCO Interior FIMBLOCO
    | WHILEREPETICAO ABREPAR OperacaoComparacao FECHAPAR BLOCO Interior FIMBLOCO
    | WHILEREPETICAO ABREPAR OperacaoComparacaoInt FECHAPAR BLOCO Interior FIMBLOCO
    | WHILEREPETICAO ABREPAR OperacaoComparacaoFloat FECHAPAR BLOCO Interior FIMBLOCO
    | WHILEREPETICAO ABREPAR OperacaoComparacaoChar FECHAPAR BLOCO Interior FIMBLOCO
    ;

Else:
    /* Cadeia vazia */
    | ELSECONDICAO BLOCO Interior FIMBLOCO
    ;

%%

int main (void) {
    yyparse();
    return 0;
}
