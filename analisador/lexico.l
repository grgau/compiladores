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
	printf ("\nTipo var: %s\n", yytext);
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

FI {
	yylval.string_simbolo  = malloc(strlen(yytext));
	strncpy(yylval.string_simbolo, yytext, strlen(yytext));
	return(FICONDICAO);
}

[(] {
	return(ABREPAR);
}

[)] {
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

[\n] {
}

[\t] {
	//return(BLOCO);
}

@.* {
}

"+" {
	return(ADICAO);
}

"-" {
	return(SUBTRACAO);
}

"*" {
	return(MULTIPLICACAO);
}

"/" {
	return(DIVISAO);
}

"!=" {
	return(DIFERENTE);
}

"=" {
	return(IGUAL);
}

"!" {
	return(NEGACAO);
}

">" {
	return(MAIOR);
}

"<" {
	return(MENOR);
}

"<=" {
	return(MENORIGUAL);
}

">=" {
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
	yylval.simbolo = yytext[0];
	return(CHAR);
}

[;] {
	return(FIMLINHA);
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
