%{
#include <stdio.h>
#include <ctype.h>
#include <math.h>
#include <string.h>
#include <Python.h>

#define YYSTYPE PyObject *

#define  YYERROR_VERBOSE
int yyerror(const char *s) {
    fprintf(stderr, "blad: %s\n", s);
    return 0;
}
int yylex(void);

#define PERFORMANCE_TEST

#ifndef PERFORMANCE_TEST
    #define dump(n,object) printf("Hit %d: %s\n", n, PyUnicode_AsUTF8(PyObject_Str(object)))
    #define result(object) printf("WYNIK: %s\n\n", PyUnicode_AsUTF8(PyObject_Str(object)))
#else
    #define dump(n,object)
    #define result(object)
#endif

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
    expr '\n' { result($1); }
;

array_contents: /* EMPTY */   { $$ = PyList_New(0); dump(1, $$); }
    | expr                    { $$ = PyList_New(1); PyList_SetItem($$, 0, $1); dump(2, $$);}
    | array_contents COMMA expr { PyList_Append($$, $3); dump(3, $$); }

array:
    LEFTARR array_contents RIGHTARR { $$ = $2; dump(4, $$); }

expr:
    array    { $$ = $1; dump(5, $$); }
    | STRING { $$ = $1; dump(6, $$); }
    | NUMBER { $$ = $1; dump(7, $$); }
;
%%
int main (void)
{
    Py_Initialize();
#if YYDEBUG == 1
    yydebug=1;
#endif
    yyparse();
    Py_Finalize();
    return 0;
}

// make clean && make && echo -ne '"asd"\n34232\n["pierwszy","drugi", 6, ["sub1", "sub2"]]\n[]\n' | ./sqf
