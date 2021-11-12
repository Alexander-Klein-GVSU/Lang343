%{
#include <stdio.h>
%}

%%
finish         printf("END");
;              printf("END_STATEMENT");
point          printf("POINT");
line           printf("LINE");
circle         printf("CIRCLE");
rectangle      printf("RECTANGLE");
set_color      printf("SET_COLOR");
[0-9]+         printf("INT");
[0-9]+\.[0-9]+ printf("FLOAT");
\s             printf("");
\t             printf("");
\n             printf("");
[:graph:]+     printf("ERROR");
%%
