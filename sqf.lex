%{
#include <stdio.h>
#include <math.h>

#include "sqf.tab.h"

%}
%option noyywrap
%%

[ \t]

[0-9]+    { 
    yylval.val = atof(yytext);
    return LICZBA;
}

[0-9]+"."[0-9]*        { 
    yylval.val = atof(yytext);
    return LICZBA;
}

"+" { return PL; }
"-" { return MN; }
"*" { return MP; }
"/" { return DV; }
"^" { return PW; }
"(" { return LP; }
")" { return RP; }

\n {return *yytext;}

%%