/*
Esse é um arquivo teste para o uso do FLEX, sendo usado para o trabalho de compiladores.
*/

%{
#include <string.h>

void comparacao(char *);
void operacoes(char *);
%}

%%

int|char|float			{
				printf("Tipo de variável encontrado: %s\n", yytext);
				}

IF				{
				printf("Condição IF encontrada: %s\n", yytext);
				}

ELSE				{
				printf("Condição ELSE encontrada: %s\n", yytext);
				}

FOR				{
				printf("Laço FOR encontrado: %s\n", yytext);
				}

WHILE				{
				printf("Laço WHILE encontrado: %s\n", yytext);
				}

FI				{
				printf("Fim de condição ou laço encontrado: %s\n", yytext);
				}

[(]				{
				printf("Abertura de parênteses encontrada!\n");
				}

[)]				{
				printf("Fechamento de parênteses encontrado!\n");
				}

[0-9]+				{
				printf("Número inteiro encontrado: %s\n", yytext);
				}

[0-9]+"."[0-9]*			{
				printf("Número flutuante encontrado: %s\n", yytext);
				}

[a-z]+[a-z0-9_]*		{
				printf("Nome de variável encontrado: %s\n", yytext);
				}

[A-Z][a-zA-Z]*			{
				printf("Nome de um método encontrado: %s\n", yytext);
				}

[\n]				{
				printf("Pulo de linha identificado\n");
				}

[\t]				{
				printf("Tabulação encontrada!\n");
				}

@.*				{
				printf("Campo de comentário encontrado: %s\n", yytext+sizeof(char));
				}


[+|-|*|/]			{
				operacoes(yytext);
				}


!=|=|!|>|<|<=|>=		{
				comparacao(yytext);
				}

"<-"				{
				printf("Símbolo de atribuição encontrado: %s\n", yytext);
				}

[ ] 				{}

.				{
				printf("Isso não é reconhecido pelo analisador léxico\n");
				}

%%

void operacoes(char *ch){
	char nome[17];

	if(!strcmp(ch,"+"))
		strcpy(nome,"ADIÇÃO");
	if(!strcmp(ch,"-"))
		strcpy(nome,"SUBTRAÇÃO");
	if(!strcmp(ch,"*"))
		strcpy(nome,"MULTIPLICAÇÃO");
	if(!strcmp(ch,"/"))
		strcpy(nome,"DIVISÃO");

	printf("O token de operação de %s foi encontrado!\n",nome);
}

void comparacao(char *ch){
	char nome[20];

	if(!strcmp(ch,">"))
		strcpy(nome,"MAIOR");
	if(!strcmp(ch,"<"))
		strcpy(nome,"MENOR");
	if(!strcmp(ch,">="))
		strcpy(nome,"MAIOR OU IGUAL");
	if(!strcmp(ch,"<="))
		strcpy(nome,"MENOR OU IGUAL");
	if(!strcmp(ch,"!="))
		strcpy(nome,"DIFERENTE");
	if(!strcmp(ch,"!"))
		strcpy(nome,"NEGAÇÃO");
	if(!strcmp(ch,"="))
		strcpy(nome,"IGUAL");
	
	printf("O token de %s foi encontrado!\n", nome);
}



int main(int argc, char **argv){
	FILE *arq;
	if(argc > 1){
		printf("O nome do arquivo aberto será %s!\n\n",argv[1]);
		if ( yyin = fopen( argv[1], "r") ){
			yylex();
			printf("\n\n");
		}else{
			printf("O arquivo não existe!!\n");
		}

	}
}
