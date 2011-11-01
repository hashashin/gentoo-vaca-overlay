CC		= gcc
CFLAGS          = -g -O2
OPTFLAGS        = -D_FILE_OFFSET_BITS=64

prefix          = /usr
sbindir		= $(prefix)/sbin

DESTDIR         = 
SBINFILES       = jazzteldecrypter

all: jazzteldecrypter

jazzteldecrypter: jazzteldecrypter.c
	$(CC) $(CFLAGS) $(OPTFLAGS) jazzteldecrypter.c -o jazzteldecrypter

install:
	install -d $(DESTDIR)$(sbindir)
	install -m 755 $(SBINFILES) $(DESTDIR)$(sbindir)

uninstall:
	rm -f $(DESTDIR)$(sbindir)/jazzteldecrypter
	

clean:
	rm -f jazzteldecrypter
