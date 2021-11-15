%{
#include <stdio.h>
#include "zoomjoystrong.h"
void yyerror(const char* msg);
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
statement:        POINT INT INT END_STATEMENT             {point($2, $3);}
              |   LINE INT INT INT INT END_STATEMENT      {line($2, $3, $4, $5);}
              |   CIRCLE INT INT INT END_STATEMENT        {circle($2, $3, $4);}
              |   RECTANGLE INT INT INT INT END_STATEMENT {rectangle($2, $3, $4, $5);}
              |   SET_COLOR INT INT INT END_STATEMENT     {if ($2 > 255 || $2 < 0 || $3 > 255 || $3 < 0 || $4 > 255 || $4 < 0) {
                                                              printf("Parameters are invalid.\n");
                                                           } else {   
                                                            set_color();
                                                            }
                                                            }
              ;

%%

void yyerror(const char* msg) {
    fprintf(stder, "There is an error on line %d.\n%s\n", yylineno, msg);
}

int main(int argc, char** argv) {
    yyparse();
}
