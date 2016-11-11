CC     = g++
CFLAGS = -Wall -Wextra -pedantic -Wno-unused-function -std=c++11 `python3m-config --cflags`
LFLAGS = -lm `python3m-config --ldflags`
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

%.yy.c: %.lex objtype.h
	$(LEX) $(LEXFLAGS) -o$(<:.lex=.yy.c) $<

%.tab.o: %.tab.c
	$(CC) -c $(CFLAGS) $<

%.tab.c: %.y objtype.h
	$(YAC) $(YACFLAGS) -o $(<:.y=.tab.c) $<

clean:
	rm -f *~ *.bak
	rm -f $(EXEC) $(OBJS) *.tab.? *.yy.?

.PHONY: clean install dist doc