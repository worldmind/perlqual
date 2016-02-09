NAME=perlqual
BINDIR=/usr/bin/

install:
	cp ./bin/$(NAME) $(BINDIR)

uninstall:
	rm -f $(BINDIR)$(NAME)
