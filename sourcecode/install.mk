PREFIX ?= /usr/local

all: $(EXE)

install: $(EXE)
	install -Dm755 $(EXE) $(DESTDIR)$(PREFIX)/bin/

clean:
	rm -f $(EXE)
