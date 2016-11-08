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


\n {return *yytext;}

%%