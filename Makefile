ifeq ($(LUA_VERSION),)
LUA_VERSION=5.2
endif

CFLAGS=-Wall -Werror -std=c89 -pedantic -g -fPIC -I/usr/include/lua$(LUA_VERSION) -D_XOPEN_SOURCE=700
LDFLAGS=-Wl,--no-undefined
LIBS=-llua$(LUA_VERSION)

all: term.so

term.o: term.c lextlib/lextlib_lua52.h

clean:
	$(RM) *.so *.o

.SUFFIXES: .c .o .so

.c.o:
	$(CC) $(CFLAGS) -o $@ -c $<

.o.so:
	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ $(LIBS)
