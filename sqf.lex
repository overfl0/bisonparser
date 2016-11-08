%{
#include <stdio.h>
#include <math.h>
#include <string.h>
#include "objtype.h"
#include "sqf.tab.h"

%}
%option noyywrap
%%

[ \t]

[0-9]+    { 
    yylval.setDouble(atof(yytext));
    return NUMBER;
}

[0-9]+"."[0-9]*        { 
    yylval.setDouble(atof(yytext));
    return NUMBER;
}

"\""[a-zA-Z0-9]*"\"" {
    yylval.setString(strdup(yytext));
    return STRING;
}

"[" { return LEFTARR; }
"]" { return RIGHTARR; }
"," { return COMMA; }

\n {return *yytext;}

%%