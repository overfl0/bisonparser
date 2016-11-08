%{
#include <stdio.h>
#include <ctype.h>
#include <math.h>
#define  YYERROR_VERBOSE
int yyerror(const char *s) {
    fprintf(stderr, "blad: %s\n", s);
    return 0;
}
int yylex(void);
%}

%union {
double val;
}
%token <val> LICZBA
%token <val> PL MN MP DV PW LP RP
%type <val> wyr
%left PL MN
%left MP DV
%left NEG
%right PW

%%
wejscie: /* nic */
    | wejscie linia
;
linia:  '\n'
    | wyr '\n' { printf("\nWYNIK: %.3g\n\n", $1); }
;
wyr:  LICZBA      { $$ = $1; }
    | wyr PL wyr { $$ = $1 + $3; }
    | wyr MN wyr { $$ = $1 - $3; }
    | wyr MP wyr { $$ = $1 * $3; }
    | wyr DV wyr { $$ = $1 / $3; }
    | wyr PW wyr { $$ = pow($1,$3); }
    | MN wyr %prec NEG { $$ = -$2; }
    | LP wyr RP { $$ = $2; }
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