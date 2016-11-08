%{
#include <stdio.h>
#include <ctype.h>
#include <math.h>
#include <string.h>
#include "objtype.h"

#define  YYERROR_VERBOSE
int yyerror(const char *s) {
    fprintf(stderr, "blad: %s\n", s);
    return 0;
}
int yylex(void);

%}

%token NUMBER
%token STRING
//%type <obj> wyr

%%
wejscie: /* nic */
    | wejscie linia
;
linia: // '\n' |
    wyr '\n' { printf("\nWYNIK: %s\n\n", ($1).toString()); }
;
/*
wyr:  NUMBER      { $$ = $1; }
    | wyr PL wyr { $$ = $1 + $3; }
    | wyr MN wyr { $$ = $1 - $3; }
    | wyr MP wyr { $$ = $1 * $3; }
    | wyr DV wyr { $$ = $1 / $3; }
    | wyr PW wyr { $$ = pow($1,$3); }
    | MN wyr %prec NEG { $$ = -$2; }
    | LP wyr RP { $$ = $2; }
;*/

wyr:
    STRING { $$ = $1; }
    | NUMBER { $$ = $1; }     //{ char tmp[100]; sprintf(tmp, "%f", $1); $$ = strdup(tmp); }

;
%%
int main (void)
{
#if YYDEBUG == 1
    yydebug=1;
#endif
    yyparse();
    return 0;
}