%{
#include <stdio.h>
#include <math.h>
#include <string.h>
#include <Python.h>

#define YYSTYPE PyObject *
#include "sqf.tab.h"

%}
%option noyywrap
%%

[ \t]

[0-9]+    { 
    yylval = PyFloat_FromDouble(atof(yytext));
    return NUMBER;
}

[0-9]+"."[0-9]*        { 
    yylval = PyFloat_FromDouble(atof(yytext));
    return NUMBER;
}

"\""[a-zA-Z0-9]*"\"" {
    yylval = PyUnicode_DecodeFSDefault(yytext);
    return STRING;
}

"[" { return LEFTARR; }
"]" { return RIGHTARR; }
"," { return COMMA; }

\n {return *yytext;}

%%