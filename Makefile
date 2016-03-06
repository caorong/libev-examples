# CC_OPTS = -Wall -Werror -lev -ggdb3 -I./include
# Use multiple -I flags for the include directories and multiple -L flags for the lib directories
CC_OPTS = -Wall -Werror -ggdb3 -I./include -I/usr/local/include
CC_EV_OPT =  -lev

all: obj/array-heap.o bin/unix-echo-server bin/unix-echo-client bin/udp-echo-server

clean:
	rm -f *.o bin/*

bin/array-test: src/array-test.c obj/array-heap.o
	$(CC) $(CC_OPTS) -o $@ $< obj/array-heap.o

obj/array-heap.o: src/array-heap.c include/array-heap.h
	$(CC) $(CC_OPTS) -o $@ -c $<

bin/udp-echo-server: src/udp-echo-server.c
	$(CC) $(CC_OPTS) $(CC_EV_OPT) -o $@ $<

bin/unix-echo-server: src/unix-echo-server.c obj/array-heap.o
	$(CC) $(CC_OPTS) $(CC_EV_OPT) -o $@ $< obj/array-heap.o

bin/unix-echo-client: src/unix-echo-client.c
	$(CC) $(CC_OPTS) $(CC_EV_OPT) -o $@ $<
