CFLAGS=-Wall -Werror -std=c89 -pedantic -g -fPIC -I/usr/include/lua5.2 -D_XOPEN_SOURCE

all: term_util.so

clean:
	$(RM) *.so *.a *.o

.SUFFIXES: .c .o .a .so

.c.o:
	$(CC) $(CFLAGS) -o $@ -c $<

.o.a:
	$(AR) r $@ $^

.o.so:
	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ $(LIBS)
