%{
#include <stdio.h>
#include <math.h>
#include <string.h>
#include "sqf.tab.h"

%}
%option noyywrap
%%

[ \t]

[0-9]+    { 
    yylval.ival = atof(yytext);
    return NUMBER;
}

[0-9]+"."[0-9]*        { 
    yylval.ival = atof(yytext);
    return NUMBER;
}

"\""[a-zA-Z0-9]*"\"" {
    yylval.sval = strdup(yytext);
    return STRING;
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