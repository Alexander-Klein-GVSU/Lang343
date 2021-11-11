%{
#include <stdio.h>
%}

%%
finish                                        printf("END");
;                                             printf("END_STATEMENT");
point\( [0-9]+, [0-9]+ \)                     printf("POINT");
line\( [0-9]+, [0-9]+, [0-9]+, [0-9]+ \)      printf("LINE");
circle\( [0-9]+, [0-9]+, [0-9]+ \)            printf("CIRCLE");
rectangle\( [0-9]+, [0-9]+, [0-9]+, [0-9]+ \) printf("RECTANGLE");
set_color\( [0-9]+, [0-9]+, [0-9]+ \)         printf("SET_COLOR");
[0-9]+                                        printf("INT");
[0-9]+\.[0-9]+                                printf("FLOAT");
\s                                            printf("");
\t                                            printf("");
\n                                            printf("");
[:graph:]+                                    printf("ERROR");
%%
