ifeq ($(LUA_VERSION),)
LUA_VERSION=5.2
endif

ifeq ($(LUA_CPPFLAGS),)
LUA_CPPFLAGS=-I/usr/include/lua$(LUA_VERSION)
endif

ifeq ($(LUA_LIBS),)
LUA_LIBS=-llua$(LUA_VERSION)
endif

ifneq ($(DEBUG),)
EXTRA_CFLAGS+= -g -O0
endif

CFLAGS=-Wall -Werror -pedantic -std=c99 -fPIC -D_XOPEN_SOURCE=700 $(EXTRA_CFLAGS)
CPPFLAGS=$(LUA_CPPFLAGS)
LDFLAGS=-Wl,--no-undefined $(LUA_LDFLAGS)
LIBS=$(LUA_LIBS)

.PHONY: all
all: term.so

term.o: term.c lextlib/lextlib_lua52.h

.PHONY: clean
clean:
	$(RM) *.so *.o

.SUFFIXES: .o .so
.o.so:
	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ $(LIBS)
