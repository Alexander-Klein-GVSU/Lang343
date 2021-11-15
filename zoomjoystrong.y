%{
#include <stdio.h>
#include "zoomjoystrong.h"
void yyerror(const char* msg);
extern int yylineno;
extern int yylex();
%}

%union {
    int fVal;
}

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT
%token ERROR
%type<fVal> INT

%%

program:          statement_list END END_STATEMENT
       ;
statement_list:   statement
              |   statement statement_list
              ;
statement:        POINT INT INT END_STATEMENT             {if ($2 < 0 || $2 > WIDTH) {
	                                                       printf("Invalid X");
							   } else if ($3 < 0 || $3 > HEIGHT) {
                                                               printf("Invalid Y");
							   } else {
  							       point($2, $3);
							   }}
              |   LINE INT INT INT INT END_STATEMENT      {if ($2 < 0 || $2 > WIDTH) {
                                                               printf("Invalid X1");
                                                           } else if ($3 < 0 || $3 > HEIGHT) {
                                                               printf("Invalid Y1");
                                                           } else if ($4 < 0 || $4 > WIDTH) {
                                                               printf("Invalid X2");
                                                           } else if ($5 < 0 || $5 > HEIGHT) {
                                                               printf("Invalid Y2");
                                                           } else {
							       line($2, $3, $4, $5);
							   }}
              |   CIRCLE INT INT INT END_STATEMENT        {if ($2 < 0 || $2 > WIDTH) {
                                                               printf("Invalid X");
                                                           } else if ($3 < 0 || $3 > HEIGHT) {
                                                               printf("Invalid Y");
                                                           } else if ($2-$4 < 0 || $2+$4 > WIDTH || $3-$4 < 0 || $3+$4 > HEIGHT) {
                                                               printf("Invalid R");
							   } else {
							       circle($2, $3, $4);
     							   }}
              |   RECTANGLE INT INT INT INT END_STATEMENT {if ($2 < 0 || $2 > WIDTH) {
                                                               printf("Invalid X");
                                                           } else if ($3 < 0 || $3 > HEIGHT) {
                                                               printf("Invalid Y");
                                                           } else if ($2-($4/2) < 0 || $2+($4/2) > WIDTH) {
                                                               printf("Invalid W");
                                                           } else if ($3-($5/2) < 0 || $3+($5/2) > HEIGHT) {
                                                               printf("Invalid H");
                                                           } else {
                                                               rectangle($2, $3, $4, $5);
                                                           }}
	      |   SET_COLOR INT INT INT END_STATEMENT	  {if ($2 < 0 || $2 > 255) {
                                                               printf("Invalid R");
                                                           } else if ($3 < 0 || $3 > 255) {
                                                               printf("Invalid G");
                                                           } else if ($4 < 0 || $4 > 255) {
                                                               printf("Invalid B");
                                                           } else {
                                                               set_color($2, $3, $4);
                                                           }}              
	      ;

%%

void yyerror(const char* msg) {
    fprintf(stderr, "There is an error on line %d.\n%s\n", yylineno, msg);
}

int main(int argc, char** argv) {
    setup();
    yyparse();
    finish();
}
