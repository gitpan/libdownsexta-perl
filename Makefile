NAMED=DataSexta
NAMEX=SextaXML
NAMEDIR=DownVideos
EXAMPLEDS=ejemplo_datasexta
EXAMPLEXML=ejemplo_sextaxml
EXAMPLEDSXML=ejemplo_datasexta_sextaxml
MANFILE=DownVideos::DataSexta
PREFIX=/usr/
DATADIR=$(PREFIX)/share
EXAMPLESDIR=$(DATADIR)/$(NAMEDIR)/examples
LIBDIR=$(DATADIR)/perl5/$(NAMEDIR)
MANDIR=$(DATADIR)/man/man3

all: libdownsexta

libdownsexta:
	@mkdir -p build

	cp $(NAMED).pm  build/$(NAMED).pm
	cp $(NAMEX).pm  build/$(NAMEX).pm
	cp $(EXAMPLEDS).pl build/$(EXAMPLEDS).pl
	cp $(EXAMPLEXML).pl build/$(EXAMPLEXML).pl
	cp $(EXAMPLEDSXML).pl build/$(EXAMPLEDSXML).pl
	cp $(MANFILE).3pm.gz build/$(MANFILE).3pm.gz

install:
	mkdir -p	\
			$(PREFIX) \
			$(DATADIR) \
			$(EXAMPLESDIR) \
			$(LIBDIR) \
			$(MANDIR)

	install -m 0664 build/$(NAMED).pm		$(LIBDIR)/
	install -m 0664 build/$(NAMEX).pm		$(LIBDIR)/
	install -m 0644 build/$(EXAMPLEDS).pl		$(EXAMPLESDIR)/
	install -m 0644 build/$(EXAMPLEXML).pl		$(EXAMPLESDIR)/
	install -m 0644 build/$(EXAMPLEDSXML).pl	$(EXAMPLESDIR)/
	install -m 0664 build/$(MANFILE).3pm.gz		$(MANDIR)/


uninstall:
	rm $(LIBDIR)/$(NAMED).pm
	rm $(LIBDIR)/$(NAMEX).pm
	rm $(MANDIR)/$(MANFILE).3pm.gz
	rm -fr $(EXAMPLESDIR)

clean:
	rm -fr build build-stamp install-stamp
	rm -fr debian/libdownsexta*
