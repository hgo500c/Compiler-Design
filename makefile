OFILES= finish.o declare.o assign.o read.o write.o gen_infix.o resolve.o lookup.o
pascal: SPparser.tab.c lex.yy.c $(OFILES)
	g++ $(OFILES) SPparser.tab.c lex.yy.c -lfl -o pascal
SPparser.tab.c:  SPparser.y
	bison --defines=pascal.tab.h SPparser.y 
lex.yy.c: SPscanner.l
	flex SPscanner.l
parser.y.c:g++ -c  $<
