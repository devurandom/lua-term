CFLAGS=-Wall -Werror -std=c89 -pedantic -g -fPIC -I/usr/include/lua5.2 -D_XOPEN_SOURCE

all: term.so

clean:
	$(RM) *.so *.o

.SUFFIXES: .c .o .so

.c.o:
	$(CC) $(CFLAGS) -o $@ -c $<

.o.so:
	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ $(LIBS)
