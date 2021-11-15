%option noyywrap

%{
#include <stdio.h>
#include "zoomjoystrong.tab.h"
%}

%%
end            {return END;}
;              {return END_STATEMENT;}
point          {return POINT;}
line           {return LINE;}
circle         {return CIRCLE;}
rectangle      {return RECTANGLE;}
set_color      {return SET_COLOR;}
[0-9]+         {return INT;}
[0-9]+\.[0-9]+ {return FLOAT;}
[ \r\t\n]      ;
.		;
%%
