%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <string>
#include <iostream>
#include <fstream>
#include <unordered_map>


extern "C" int yylex();
extern "C" int yyparse();
extern FILE * yyin;
extern int line_no;

std::string srcFilePath;
std::ofstream outFile;
std::unordered_map<std::string, char*> sym_table;
std::unordered_map<std::string, char*> mem_table;

void finish();
void decl_id(char* identifier, char* type);
void assign(char* target, char* source);
char* resolve(char* identifier);
void read_id(const char* identifier, const char* type);
void write_expr(const char* identifier, const char* type);
char* lookup(char* identifier);

void error(const char* msg);
void yyerror(const char* msg);

char* _decl_type_;

%}
%union{
        char* 	sval;
	char* 	cval;
	char*	rval;
	char*	ival;
}

%token PROGRAM VAR START END
%token ID INTEGER REAL CHARACTER
%token PERIOD SEMICOLON COMMA LPAREN RPAREN COLON UNDERSCORE SQUOTE
%token PLUSOP MINUSOP
%token ASSIGNOP READ WRITE

%left PLUSOP MINUSOP

%token <sval> INTLITERAL
%token <sval> REALLITERAL
%token <sval> CHARLITERAL

%type <sval> ident
%type <sval> expression
%type <sval> expr
%type <sval> term
%type <sval> add_op

%type <sval> type
%type <sval> id_list

%start system_goal

%%

system_goal 	: program {finish();}
		;

program	    	: PROGRAM variables START statements END PERIOD
		;

variables	: SEMICOLON
	  	| VAR declarations
		;

declarations	: declaration
	  	| declarations declaration
		;

declaration	: type {_decl_type_ = $1;} id_list SEMICOLON
		;

id_list		: ident {decl_id($1, _decl_type_); free($1);}
	 	| ident {decl_id($1, _decl_type_);} ASSIGNOP expression {assign($1, $4);}
		| id_list COMMA ident {decl_id($3, _decl_type_); free($3);}
		| id_list COMMA ident {decl_id($3, _decl_type_);} ASSIGNOP expression {assign($3, $6);}
		;


statements      : statement
                | statements statement
                ;

statement	: ident {resolve($1);} ASSIGNOP expression {assign($1,$4);} SEMICOLON
                | READ lparen id_list rparen SEMICOLON
                | WRITE lparen expressions rparen SEMICOLON
                | SEMICOLON
		;

expressions  	: expression {write_expr($1, _decl_type_);}
                | expressions COMMA expression {write_expr($3, _decl_type_);}
		;

expression 	: expr {strcpy($$,$1);}
                ;

expr    	: term {strcpy($$,$1);}
		| expr add_op term
		| {error("EXPRESSION EXPECTED, BUT FOUND");}
		;

term 	  	: lparen expression rparen {strcpy($$,$2);}
		| ident {strcpy($$, lookup($1));}
	    	| INTLITERAL {strcpy($$,$1);}
		| REALLITERAL {strcpy($$,$1);}
		| CHARLITERAL {strcpy($$,$1);}
		| {error("NUMERIC VALUE EXPECTED, BUT FOUND");}
		;

lparen 		: LPAREN
		| {error("( EXPECTED , BUT FOUND");}
		;

rparen		: RPAREN
		| {error(") EXPECTED , BUT FOUND");}
		;

add_op  	: PLUSOP {strcpy ($$,"Add");}
		| MINUSOP {strcpy ($$,"Sub");}
		;

type		: INTEGER {strcpy($$, "integer");}
      		| REAL {strcpy($$, "real");}
		| CHARACTER {strcpy($$, "character");}
		;

ident		: ID {strcpy($$, yylval.sval);}
       		| {error("Expected identifer");}
		; 

%%

int main( int argc, char **argv )
{
	char * loc;
	if( argc != 2 )
		std::cout << "Usage: pascal inputfile\n";
	else
	{
		srcFilePath = argv[1]; // assume you are not mucking with pointers
		yyin = fopen( *++argv, "r" );
		if( yyin == NULL )
		{
			std::cout << "spascal: Couldn't open " << *argv << std::endl;
			exit( 1 );
		}
		
		std::string fileName = srcFilePath.substr(0, srcFilePath.rfind('.'));
		std::string asmFileName = fileName + ".asm";

		outFile.open(asmFileName);
		yyparse();
		fclose( yyin );
		outFile.close();
	}
}

void error(const char* msg) {
	std::cout << "[" << srcFilePath << " : " <<  line_no << "] " << msg << std::endl;
	exit(-1);
}

void yyerror(const char s[]) {
  std::cout << "[" << srcFilePath << " : " << line_no << "] Parser error. Halting on illegal character " << yylval.sval << std::endl;
  // might as well halt now:
  exit(-1);
} 
