headers=$(wildcard *.h)
sources=$(wildcard *.c)
objects=$(patsubst %.c,%.o,$(sources))

CC=gcc
CFLAGS=-g -O2 -I/usr/local/include -Wall
LIBS= -L/usr/local/lib -lrote
LDFLAGS=
OMNITTY_VERSION=0.3.0
prefix=/usr
exec_prefix=${prefix}
bindir=${exec_prefix}/bin
mandir=${prefix}/man

CFLAGS+=-DOMNITTY_VERSION=\"$(OMNITTY_VERSION)\"
CFLAGS+=-DCSSHDIR=\"$(prefix)\"
CFLAGS+=-DCSSHBIN=\"$(sshbin)\"

omnitty: $(objects)
	$(CC) $(CFLAGS) -o omnitty $(objects) $(LDFLAGS) $(LIBS)

-include .depends

.depends: $(sources) $(headers)
	$(CC) $(CFLAGS) -MM $(sources) >.depends

clean:
	rm -f *.o .depends omnitty

distclean: clean
	rm -rf autom4te.cache config.status config.log Makefile

pristine: distclean
	rm -f configure

install: omnitty
	mkdir -p $(DESTDIR)$(bindir)
	cp omnitty $(DESTDIR)$(bindir)

.PHONY: distclean clean pristine

