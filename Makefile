# Makefile for thes-id/mythes-id
# Copyright 2018  Ali Ahmadi, <idnux09@gmail.com>
# All rights reserved.
CONV_SCRIPT = tool/th_gen_idx.pl
SRCFILE = thes_id.txt
OUTFILES = th_id_ID_v2.dat th_id_ID_v2.idx
PACKAGE = mythes-id
VERSION = 1.0.1
LOEXT = indonesian-thesaurus
LOEXT_PACKAGE = $(LOEXT)-$(VERSION)

EXT_FILES = data/*
DOCDIR = $(DESTDIR)/usr/share/doc/$(PACKAGE)
LOEXT_DIR = $(LOEXT)
MYTHESDIR = $(DESTDIR)/usr/share/mythes
MYSPELL_LINKDIR = $(DESTDIR)/usr/share/myspell/dicts

DOC_FILES = README LICENSE INSTALL
EXTDOC_FILES = README LICENSE

all : $(OUTFILES)

th_id_ID_v2.dat : $(SRCFILE)
	cp -avf $(SRCFILE) th_id_ID_v2.dat
	
th_id_ID_v2.idx : th_id_ID_v2.dat
	cat th_id_ID_v2.dat | $(CONV_SCRIPT) > th_id_ID_v2.idx
	
install : install_data install_link install_doc

install_data :
	install -vdm 755 $(MYTHESDIR)
	install -vm 644 $(OUTFILES) $(MYTHESDIR)

install_link :
	install -dm 755 $(MYSPELL_LINKDIR)
	ln -svf $(MYTHESDIR)/th_id_ID_v2.dat $(MYSPELL_LINKDIR)
	ln -svf $(MYTHESDIR)/th_id_ID_v2.idx $(MYSPELL_LINKDIR)

install_doc :
	install -vdm 755 $(DOCDIR)
	install -vm 644 $(DOC_FILES) $(DOCDIR)

uninstall :
	unlink $(MYSPELL_LINKDIR)/th_id_ID_v2.dat
	unlink $(MYSPELL_LINKDIR)/th_id_ID_v2.idx
	rm -vf $(MYTHESDIR)/th_id_ID_v2.dat
	rm -vf $(MYTHESDIR)/th_id_ID_v2.idx
	rm -vrf $(DOCDIR)

create_loext :
	install -dm 755 $(LOEXT_DIR)
	cp -avf $(OUTFILES) $(EXTDOC_FILES) $(EXT_FILES) $(LOEXT_DIR)
	bsdtar -a -cf $(LOEXT_PACKAGE).zip $(LOEXT_DIR)
	mv -vf $(LOEXT_PACKAGE).zip $(LOEXT_PACKAGE).oxt
	rm -vrf $(LOEXT_DIR)

.PHONY : clean 

clean :
	rm -vf $(OUTFILES) $(LOEXT_PACKAGE).oxt
