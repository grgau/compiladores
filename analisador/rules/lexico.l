/*
Esse é um arquivo feito para o uso no FLEX, sendo usado para o trabalho de compiladores.
*/

%{
#include <string.h>
#include "sintatico.tab.h"
void yyerror(char *);
%}

%%
int|char|float {
	yylval.string_simbolo = malloc(strlen(yytext));
	strncpy(yylval.string_simbolo, yytext, strlen(yytext));
	return(TIPOVAR);
}

IF {
	yylval.string_simbolo  = malloc(strlen(yytext));
	strncpy(yylval.string_simbolo, yytext, strlen(yytext));
	return(IFCONDICAO);
}

ELSE {
	yylval.string_simbolo  = malloc(strlen(yytext));
	strncpy(yylval.string_simbolo, yytext, strlen(yytext));
	return(ELSECONDICAO);
}

FOR {
	yylval.string_simbolo  = malloc(strlen(yytext));
	strncpy(yylval.string_simbolo, yytext, strlen(yytext));
	return(FORREPETICAO);
}

WHILE {
	yylval.string_simbolo  = malloc(strlen(yytext));
	strncpy(yylval.string_simbolo, yytext, strlen(yytext));
	return(WHILEREPETICAO);
}

[(] {
    yylval.simbolo = yytext[0];
	return(ABREPAR);
}

[)] {
    yylval.simbolo = yytext[0];
	return(FECHAPAR);
}

[0-9]+ {
	yylval.inteiro = atoi(yytext);
	return (INTEIRO);
}

[0-9]+"."[0-9]* {
	yylval.real = atof(yytext);
	return (REAL);
}

[a-z]+[a-z0-9_]* {
	yylval.string_simbolo  = malloc(strlen(yytext));
	strncpy(yylval.string_simbolo, yytext, strlen(yytext));
	return(VARIAVEL);
}

[A-Z][a-zA-Z]* {
	yylval.string_simbolo  = malloc(strlen(yytext));
	strncpy(yylval.string_simbolo, yytext, strlen(yytext));
	return(METODO);
}

[\t] {
}

[\n] {
}

[{] {
    yylval.simbolo = yytext[0];
    return(BLOCO);
}

[}] {
    yylval.simbolo = yytext[0];
    return(FIMBLOCO);
}

@.* {
}

"+" {
    yylval.simbolo = yytext[0];
	return(ADICAO);
}

"-" {
    yylval.simbolo = yytext[0];
	return(SUBTRACAO);
}

"*" {
    yylval.simbolo = yytext[0];
	return(MULTIPLICACAO);
}

"/" {
    yylval.simbolo = yytext[0];
	return(DIVISAO);
}

"!=" {
    yylval.string_simbolo = malloc(strlen(yytext));
    strncpy(yylval.string_simbolo, yytext, strlen(yytext));
	return(DIFERENTE);
}

"=" {
    yylval.simbolo = yytext[0];
	return(IGUAL);
}

"!" {
    yylval.simbolo = yytext[0];
	return(NEGACAO);
}

">" {
    yylval.simbolo = yytext[0];
	return(MAIOR);
}

"<" {
    yylval.simbolo = yytext[0];
	return(MENOR);
}

"<=" {
    yylval.string_simbolo = malloc(strlen(yytext));
    strncpy(yylval.string_simbolo, yytext, strlen(yytext));
	return(MENORIGUAL);
}

">=" {
    yylval.string_simbolo = malloc(strlen(yytext));
    strncpy(yylval.string_simbolo, yytext, strlen(yytext));
	return(MAIORIGUAL);
}

"<-" {
	yylval.string_simbolo = malloc(strlen(yytext));
	strncpy(yylval.string_simbolo, yytext, strlen(yytext));
	return(ATRIBUICAO);
}

[ ] {											//Não faz nada quando lê espaço
}

[\'][a-zA-Z][\'] {
	yylval.string_simbolo = malloc(strlen(yytext));
	strncpy(yylval.string_simbolo, yytext, strlen(yytext));
	return(CHAR);
}

[;] {
    yylval.simbolo = yytext[0];
	return(FIMLINHA);
}

[,] {
    yylval.simbolo = yytext[0];
    return(VIRGULA);
}

[\"][a-zA-Z ]*[\"] {
	yylval.string_simbolo = malloc(strlen(yytext));
	strncpy(yylval.string_simbolo, yytext, strlen(yytext));
	return(STRING);
}

. {
	yyerror("Caracter desconhecido");						//Qualquer outra coisa é recusada pelo analisador léxico
}
%%
