%{
#include <iostream>
#include <stdlib.h>
#include "pascal.tab.h"

extern "C" int yylex();

int line_no = 1; 
%}

letter		[a-zA-Z]
digit		[0-9]

semicolon	[;]
period		[\.]
comma		[,]
underscore	[_]
lparen		[(]
rparen		[)]
colon		[:]
squote		[']

assignop	[:][=]
plusop		[+]
minusop		[-]

intliteral      [+|-]?(0|([1-9]{digit}*))
realliteral	{intliteral}\.[0-9]+
charliteral	'{letter}'
id              ({letter}|{underscore})({letter}|{digit}|{underscore})*

%%
[ \t]+                                          {/* do nothing */}
[\n] 	                                        {line_no++;}
[Pp][Rr][Oo][Gg][Rr][Aa][Mm]			{return PROGRAM;}
[Vv][Aa][Rr]					{return VAR;}
[Bb][Ee][Gg][Ii][Nn]                            {return START;}
[Ee][Nn][Dd]                                    {return END;}

{underscore}					{return UNDERSCORE;}
{period}					{return PERIOD;}
{colon}						{return COLON;}
{semicolon}                                     {return SEMICOLON;}
{comma}						{return COMMA;}
{rparen}					{return RPAREN;}
{lparen}					{return LPAREN;}
{squote}					{return SQUOTE;}

{assignop}					{return ASSIGNOP;}
{plusop}					{return PLUSOP;}
{minusop}					{return MINUSOP;}

[Ii][Nn][Tt][Ee][Gg][Ee][Rr]			{yylval.sval = strdup(yytext); return INTEGER;}
[Rr][Ee][Aa][Ll]				{yylval.sval = strdup(yytext); return REAL;}
[Cc][Hh][Aa][Rr][Aa][Cc][Tt][Ee][Rr]		{yylval.sval = strdup(yytext); return CHARACTER;}

{intliteral}                                    {yylval.sval = strdup(yytext); return INTLITERAL;}
{realliteral}                                   {yylval.sval = strdup(yytext); return REALLITERAL;}
{charliteral}                                   {yylval.sval = strdup(yytext); return CHARLITERAL;}

{id}						{yylval.sval = strdup(yytext); return ID;}

[^,]		{ yylval.sval = strdup(yytext); std::cout << "syntax error: " << yytext << std::endl; }
%%

