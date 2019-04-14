/* Definition section */
%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <ctype.h>
%}

/* Define regular expression label */

letter [a-zA-Z]
digit [0-9]
id {letter}+({letter}|{digit})*
number {digit}+

/* Rules section */
%%

"+" 	{ printf("%s \t ADD\n", yytext); }
"-"		{ printf("%s \t SUB\n", yytext); }
"*"		{ printf("%s \t MUL\n", yytext); }
"/"		{ printf("%s \t DIV\n", yytext); }
"%"		{ printf("%s \t MOD\n", yytext); }
"++"	{ printf("%s \t INC\n", yytext); }
"--"	{ printf("%s \t DEC\n", yytext); }
">"		{ printf("%s \t MT\n", yytext); }
"<"		{ printf("%s \t LT\n", yytext); }
">="	{ printf("%s \t MTE\n", yytext); }
"<="	{ printf("%s \t LTE\n", yytext); }
"=="	{ printf("%s \t EQ\n", yytext); }
"!="	{ printf("%s \t NE\n", yytext); }
"["		{ printf("%s \t LSB\n", yytext); }
"]"		{ printf("%s \t RSB\n", yytext); }
","		{ printf("%s \t COMMA\n", yytext); }
";"		{ printf("%s \t SEMICOLON\n", yytext); }
"print"		{ printf("%s \t PRINT\n", yytext); }
"if"		{ printf("%s \t IF\n", yytext); }
"else"		{ printf("%s \t ELSE\n", yytext); }
"for"		{ printf("%s \t FOR\n", yytext); }
"while"		{ printf("%s \t WHILE\n", yytext); }

"\""	{ BEGIN(STR);
			printf("%s \t QUOTA\n", yytext);
		}
<STR>"\""		{BEGIN(INITIAL);
					printf("%s \t QUOTA\n", yytext);
				}
<STR>[^\"]*		{printf("%s \t STR_CONST\n", yytext);}


""		{ printf("%s \t MUL\n", yytext); }
"*"		{ printf("%s \t MUL\n", yytext); }
"*"		{ printf("%s \t MUL\n", yytext); }

{id}	{ printf("%s \t ID\n", yytext); }
\n			{;}


%%

/*	C Code section */
int yywrap(void)
{
    return 1;
}

int main(int argc,char *argv[])
{
	yyin = fopen(argv[1],"r");
	yylex();
	printf("\nParse over, the line number is 1.\n\n");
	printf("comment: 1 lines\n\n");

	return 0;
}
