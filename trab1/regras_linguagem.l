/*
Esse é um arquivo feito para o uso no FLEX, sendo usado para o trabalho de compiladores.
*/

%{
#include <string.h>

void comparacao(char *);			//Retorna token de comparação do caractere passado para a função
void operacoes(char *);				//Retorna o token de operação do caractere passado para a função
%}

%%

int|char|float			{
				printf("Tipo de variável encontrado: %s\n", yytext);					//Tipo de variável
				}

IF				{
				printf("Condição IF encontrada: %s\n", yytext);						//Condição "SE"
				}

ELSE				{
				printf("Condição ELSE encontrada: %s\n", yytext);					//Condição "SENÃO"
				}

FOR				{
				printf("Laço FOR encontrado: %s\n", yytext);						//Laço de repetição "PARA"
				}

WHILE				{
				printf("Laço WHILE encontrado: %s\n", yytext);						//Laço de repetição "ENQUANTO"
				}

FI				{
				printf("Fim de condição ou laço encontrado: %s\n", yytext);				//Sinalizador de fim de condição ou laço de repetição
				}

[(]				{
				printf("Abertura de parênteses encontrada!\n");						//Abre parênteses
				}

[)]				{
				printf("Fechamento de parênteses encontrado!\n");					//Fecha parênteses
				}

[0-9]+				{
				printf("Número inteiro encontrado: %s\n", yytext);					//Números inteiros
				}

[0-9]+"."[0-9]*			{
				printf("Número flutuante encontrado: %s\n", yytext);					//Números de ponto flutuante
				}

[a-z]+[a-z0-9_]*		{
				printf("Nome de variável encontrado: %s\n", yytext);					//Nome de variável
				}

[A-Z][a-zA-Z]*			{
				printf("Nome de um método encontrado: %s\n", yytext);					//Nome de métodos/funções
				}

[\n]				{
				printf("Pulo de linha identificado\n");							//Sinalizador de nova linha no arquivo de entrada
				}

[\t]				{
				printf("Tabulação encontrada!\n");							//Sinalizador de tabulação no arquivo de entrada
				}

@.*				{
				printf("Campo de comentário encontrado: %s\n", yytext+sizeof(char));			//Campo de comentário até o fim da linha atual
				}


[+|-|*|/]			{
				operacoes(yytext);									//Passa o símbolo de operação aritmética para a função, que retorna o respectivo token para a operação
				}


!=|=|!|>|<|<=|>=		{
				comparacao(yytext);									//Passa o símbolo de comparação para a função, que retorna o respectivo token para a comparação
				}

"<-"				{
				printf("Símbolo de atribuição encontrado: %s\n", yytext);				//Símbolo de atribuição
				}

[ ] 				{											//Não faz nada quando lê espaço
				}

[\'][a-zA-Z][\']   		{
				printf("Um caractere foi encontrado!\n");						//Caractere
				}

.				{
				printf("Isso não é reconhecido pelo analisador léxico\n");				//Qualquer outra coisa é recusada pelo analisador léxico
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
