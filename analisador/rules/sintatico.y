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
%token <inteiro> INTEIRO           //Token de ER que retornam int
%token <real> REAL                 //Token de ER que retornam float
%token <simbolo> VIRGULA BLOCO FIMBLOCO ABREPAR FECHAPAR FIMLINHA ADICAO SUBTRACAO MULTIPLICACAO DIVISAO MAIOR MENOR MAIORIGUAL MENORIGUAL DIFERENTE NEGACAO IGUAL      //Token de ER que retornam char
%token <string_simbolo> TIPOVAR IFCONDICAO ELSECONDICAO FORREPETICAO WHILEREPETICAO VARIAVEL METODO ATRIBUICAO CHAR STRING      //Token de ER que retornam strings

/*  Regras da Gramatica */
%start Funcao       //Regra de produção inicial
%%

Funcao:
    TIPOVAR METODO ABREPAR MaisDeUmArgumento FECHAPAR BLOCO Interior FIMBLOCO       //Regra de produção obedece estrutura tipo: int Metodo (parametros) { ... }
    ;

Interior:
    /* Cadeia vazia */          //Interior de um metodo pode ser vazio
    | Partes Interior           //Interior de um metodo pode ser composto por partes (Linhas de codigo) ou por outro Interior (no caso outro escopo)
    ;

Partes:                                                         //Possiveis produções internas a um BLOCO de codigo delimitado pro { e }
    TIPOVAR MaisDeUmArgumento FIMLINHA                          //Declaracao de uma variavel com seu tipo, ex: int var1, var2, var3;
    | VARIAVEL ATRIBUICAO INTEIRO FIMLINHA                      //Atribuicao de valor int para uma variavel
    | VARIAVEL ATRIBUICAO REAL FIMLINHA                         //Atribuicao de valor float para uma variavel
    | VARIAVEL ATRIBUICAO CHAR FIMLINHA                         //Atribuicao de valor char para uma variavel
    | VARIAVEL ATRIBUICAO VARIAVEL FIMLINHA                     //Atribuicao de uma variavel para outra variavel, ex: var1 <- var2;
    | VARIAVEL ATRIBUICAO OperacaoAritmetica FIMLINHA           //Atribuicao de uma operacao entre variaveis para uma variavel
    | VARIAVEL ATRIBUICAO OperacaoAritmeticaInt FIMLINHA        //Atribuicao de uma operacao entre uma variavel e inteiro para uma variavel, ex: var1 <- var1 + 2;
    | VARIAVEL ATRIBUICAO OperacaoAritmeticaFloat FIMLINHA      //Atribuicao de uma operacao entre uma variavel e um float para uma variavel
    | METODO ABREPAR MaisDeUmArgumento FECHAPAR FIMLINHA        //Chamar uma funcao
    | Condicao                                                  //Simbolo nao-terminal de condicoes (IF/ELSE, FOR, WHILE)
    ;

MaisDeUmArgumento:                                              //Simbolo não-terminal para aceitar nenhum, um, ou mais argumentos em funções e declarações de variaveis
    /* Cadeia vazia */                                          //Argumentos de uma função podem ser vazios, ex: int Funcao ()
    VARIAVEL VIRGULA MaisDeUmArgumento                          //Para mais de um argumento, separados por virgulas
    | VARIAVEL                                                  //Para um argumento
    ;

OperacaoAritmetica:                                             //Operacoes aritméticas entre variavel e variavel
    VARIAVEL ADICAO VARIAVEL
    | VARIAVEL SUBTRACAO VARIAVEL
    | VARIAVEL MULTIPLICACAO VARIAVEL
    | VARIAVEL DIVISAO VARIAVEL
    ;

OperacaoAritmeticaInt:                                          //Operacoes aritméticas entre variável e inteiro
    VARIAVEL ADICAO INTEIRO
    | VARIAVEL SUBTRACAO INTEIRO
    | VARIAVEL MULTIPLICACAO INTEIRO
    | VARIAVEL DIVISAO INTEIRO
    ;

OperacaoAritmeticaFloat:                                        //Operações aritméticas entre variável e float
    VARIAVEL ADICAO REAL
    | VARIAVEL SUBTRACAO REAL
    | VARIAVEL MULTIPLICACAO REAL
    | VARIAVEL DIVISAO REAL
    ;

OperacaoComparacao:                                             //Operações de comparação entre variável e variável
    VARIAVEL MAIOR VARIAVEL
    | VARIAVEL MENOR VARIAVEL
    | VARIAVEL MAIORIGUAL VARIAVEL
    | VARIAVEL MENORIGUAL VARIAVEL
    | VARIAVEL DIFERENTE VARIAVEL
    | VARIAVEL IGUAL VARIAVEL
    | NEGACAO VARIAVEL
    ;

OperacaoComparacaoInt:                                          //Operações de comparação entre variável e inteiro
    VARIAVEL MAIOR INTEIRO
    | VARIAVEL MENOR INTEIRO
    | VARIAVEL MAIORIGUAL INTEIRO
    | VARIAVEL MENORIGUAL INTEIRO
    | VARIAVEL DIFERENTE INTEIRO
    | VARIAVEL IGUAL INTEIRO
    ;

OperacaoComparacaoFloat:                                        //Operações de comparação entre variável e float
    VARIAVEL MAIOR REAL
    | VARIAVEL MENOR REAL
    | VARIAVEL MAIORIGUAL REAL
    | VARIAVEL MENORIGUAL REAL
    | VARIAVEL DIFERENTE REAL
    | VARIAVEL IGUAL REAL
    ;

OperacaoComparacaoCharString:                                   //Operações de comparação entre variável e char/string
    VARIAVEL DIFERENTE CHAR
    | VARIAVEL IGUAL CHAR
    | VARIAVEL DIFERENTE STRING
    | VARIAVEL IGUAL STRING
    ;

Condicao:                                                       //Regras de estruturas de decisão (IF/ELSE) e repetição (FOR/WHILE)
    IFCONDICAO ABREPAR OperacaoComparacao FECHAPAR BLOCO Interior FIMBLOCO Else                 //Estrutura de um comando IF com comparação entre variáveis, ex: IF (var1 < var2) { ... }
    | IFCONDICAO ABREPAR OperacaoComparacaoInt FECHAPAR BLOCO Interior FIMBLOCO Else            //Estrutura de um comando IF com comparação entre variável e inteiro, ex: IF (var1 < 10) { ... }
    | IFCONDICAO ABREPAR OperacaoComparacaoFloat FECHAPAR BLOCO Interior FIMBLOCO Else          //Estrutura de um comando IF com comparação entre variável e float, ex: IF (var1 < 1.2) { ... }
    | IFCONDICAO ABREPAR OperacaoComparacaoCharString FECHAPAR BLOCO Interior FIMBLOCO Else     //Estrutura de um comando IF com comparação entre variável e char/string, ex: IF (var1 != 'a') { ... }
    | FORREPETICAO ABREPAR VARIAVEL ATRIBUICAO INTEIRO VIRGULA OperacaoComparacaoInt VIRGULA VARIAVEL ATRIBUICAO OperacaoAritmeticaInt FECHAPAR BLOCO Interior FIMBLOCO     //Estrutura de um comando de repetição FOR, ex: FOR (var1 <- 0, var1 < 10, var1 <- var1 + 1) { ... }
    | WHILEREPETICAO ABREPAR OperacaoComparacao FECHAPAR BLOCO Interior FIMBLOCO                //Estrutura de um comando WHILE com comparação entre variáveis
    | WHILEREPETICAO ABREPAR OperacaoComparacaoInt FECHAPAR BLOCO Interior FIMBLOCO             //Estrutura de um comando WHILE com comparação entre variável e inteiro, ex: WHILE (var1 < var2) { ... }
    | WHILEREPETICAO ABREPAR OperacaoComparacaoFloat FECHAPAR BLOCO Interior FIMBLOCO           //Estrutura de um comando WHILE com comparação entre variável e float, ex: WHILE (var1 < 2.0) { ... }
    | WHILEREPETICAO ABREPAR OperacaoComparacaoCharString FECHAPAR BLOCO Interior FIMBLOCO      //Estrutura de um comando WHILE com comparação entre variável e char/string, ex WHILE (var1 != 'exemplo') { ... }
    ;

Else:
    /* Cadeia vazia */                                          //Caso de não haver else
    | ELSECONDICAO BLOCO Interior FIMBLOCO                      //Caso de haver else
    ;

%%

int main (void) {
    yyparse();                                                  //Chama função de "parseador"
    return 0;
}
