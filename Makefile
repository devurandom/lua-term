CFLAGS=-Wall -Werror -std=c89 -pedantic -g -fPIC -D_XOPEN_SOURCE

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
