SRC = sshfs-map.c
OBJ = sshfs-map
UOBJ = sshfs-unmap

CFLAGS = -g3 -ggdb -O2

DESTDIR ?= /
PREFIX ?= usr/local

all: $(OBJ)

install: all
	install -m0755 $(OBJ) $(DESTDIR)/$(PREFIX)/bin/$(OBJ)
	ln -sf $(PREFIX)/bin/$(OBJ) $(PREFIX)/bin/$(UOBJ)

doc: sshfs-map.7

clean:
	rm -f $(OBJ)
