CC     = gcc
CFLAGS = -Wall -ansi -pedantic -Wno-unused-function -Wno-implicit-function-declaration
LFLAGS = -lm 
LEX    = flex
LEXFLAGS =
YAC    = bison
YACFLAGS = -v -d

EXEC   = sqf
OBJS   = $(EXEC).tab.o $(EXEC).yy.o

all: $(EXEC)

$(EXEC): $(OBJS)
	$(CC) $+ -o $@ $(LFLAGS)

%.o: %.c
	$(CC) -c $(CFLAGS) $<

%.yy.o: %.yy.c
	$(CC) -c $(CFLAGS) $<

%.yy.c: %.lex
	$(LEX) $(LEXFLAGS) -o$(<:.lex=.yy.c) $<

%.tab.o: %.tab.c
	$(CC) -c $(CFLAGS) $<

%.tab.c: %.y
	$(YAC) $(YACFLAGS) -o $(<:.y=.tab.c) $<

clean:
	rm -f *~ *.bak
	rm -f $(EXEC) $(OBJS) *.tab.? *.yy.?

.PHONY: clean install dist doc