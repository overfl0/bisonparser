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
%token LEFTARR
%token RIGHTARR

%left COMMA

%%
input: /* EMPTY */
    | input line
;
line: // '\n' |
    expr '\n' { printf("\nWYNIK: %s\n\n", ($1).toString()); }
;

array_contents: /* EMPTY */   { pobject obj; obj.type = array; $$ = obj; printf("Hit 1: %s\n", $$.toString());}
    | expr                    { pobject obj; obj.type = array; obj.arr.push_back($1); $$ = obj; printf("Hit 2: %s\n", $$.toString());}
    | array_contents COMMA expr { $$.arr.push_back($3); printf("Hit 3: %s\n", $$.toString());}

array:
    LEFTARR array_contents RIGHTARR { $$ = $2; printf("Hit 4: %s\n", $$.toString());}

expr:
    array    { $$ = $1; printf("Hit 7: %s\n", $$.toString());}
    | STRING { $$ = $1; printf("Hit 5: %s\n", $$.toString());}
    | NUMBER { $$ = $1; printf("Hit 6: %s\n", $$.toString());}
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

// make clean && make && echo -ne '"asd"\n34232\n["pierwszy","drugi", 6, ["sub1", "sub2"]]\n[]\n' | ./sqf
