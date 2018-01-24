# Makefile for thes-id/mythes-id
# Copyright 2018  Ali Ahmadi, <idnux09@gmail.com>
# All rights reserved.
CONV_SCRIPT = tool/th_gen_idx.pl
SRCFILE = thes_id.txt
OUTFILES = th_id_ID_v2.dat th_id_ID_v2.idx
INSTALL = install
INSTALL_DATA = $(INSTALL) -m 644
SYMLINK = ln -s
MKDIR = $(INSTALL) -dm 755
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
REM_FILES = $(DESTDIR)/usr/share/mythes/$(OUTFILES) $(DESTDIR)/usr/share/myspell/dicts/$(OUTFILES)

all : $(OUTFILES)

th_id_ID_v2.dat : $(SRCFILE)
	cp -avf $(SRCFILE) th_id_ID_v2.dat
	
th_id_ID_v2.idx : th_id_ID_v2.dat
	cat th_id_ID_v2.dat | $(CONV_SCRIPT) > th_id_ID_v2.idx
	
install : install_data install_link install_doc

install_data :
	$(MKDIR) $(MYTHESDIR)
	$(INSTALL_DATA) $(OUTFILES) $(MYTHESDIR)

install_link :
	$(MKDIR) $(MYSPELL_LINKDIR)
	$(SYMLINK) $(MYTHESDIR)/th_id_ID_v2.dat $(MYSPELL_LINKDIR)
	$(SYMLINK) $(MYTHESDIR)/th_id_ID_v2.idx $(MYSPELL_LINKDIR)

install_doc :
	$(MKDIR) $(DOCDIR)
	$(INSTALL_DATA) $(DOC_FILES) $(DOCDIR)

uninstall :
	rm -f $(MYTHESDIR)/th_id_ID_v2.dat
	rm -f $(MYTHESDIR)/th_id_ID_v2.idx
	rm -f $(MYSPELL_LINKDIR)/th_id_ID_v2.dat
	rm -f $(MYSPELL_LINKDIR)/th_id_ID_v2.idx
	rm -rf $(DOCDIR)

create_loext :
	$(MKDIR) $(LOEXT_DIR)
	cp -avf $(OUTFILES) $(EXTDOC_FILES) $(EXT_FILES) $(LOEXT_DIR)
	bsdtar -a -cf $(LOEXT_PACKAGE).zip $(LOEXT_DIR)
	mv -vf $(LOEXT_PACKAGE).zip $(LOEXT_PACKAGE).oxt
	rm -rf $(LOEXT_DIR)

.PHONY : clean 

clean :
	rm -f $(OUTFILES) $(LOEXT_PACKAGE).oxt
