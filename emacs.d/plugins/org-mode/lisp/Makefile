ORG-INSTALL = $(BATCH) \
	 --eval '(require '"'"'autoload)' \
	 --eval '(find-file "org-install.el")' \
	 --eval '(erase-buffer)' \
	 --eval '(insert ";;; org-install.el --- autogenerated file, do not edit\n;;\n;;; Code:\n")' \
	 --eval '(mapc (lambda (x) (generate-file-autoloads (symbol-name x)))\
                   (quote ($(LISPF) org-version.el)))' \
	 --eval '(insert "\f\n(provide '"'"'org-install)\n")' \
	 --eval '(insert ";; Local Variables:\n;; version-control: never\n")' \
	 --eval '(insert ";; no-byte-compile: t\n;; no-update-autoloads: t\n")' \
	 --eval '(insert ";; coding: utf-8\n;; End:\n;;; org-install.el ends here\n")' \
	 --eval '(save-buffer)'
ORG-VERSION = $(BATCH) \
	 --eval '(find-file "org-version.el")' \
	 --eval '(erase-buffer)' \
	 --eval '(insert ";;; org-version.el --- autogenerated file, do not edit\n;;\n;;; Code:\n")' \
	 --eval '(insert ";;;\#\#\#autoload\n")' \
	 --eval '(insert "(defconst org-release \"$(ORGVERSION)\"\n")' \
	 --eval '(insert "  \"The release version of org-mode.\n")' \
	 --eval '(insert "  Inserted by installing org-mode or when a release is made.\")\n")' \
	 --eval '(insert ";;;\#\#\#autoload\n")' \
	 --eval '(insert "(defconst org-git-version \"$(GITVERSION)\"\n")' \
	 --eval '(insert "  \"The Git version of org-mode.\n")' \
	 --eval '(insert "  Inserted by installing org-mode or when a release is made.\")\n")' \
	 --eval '(insert ";;;\#\#\#autoload\n")' \
	 --eval '(insert "(defconst org-odt-data-dir \"$(datadir)\"\n")' \
	 --eval '(insert "  \"The location of ODT styles.\")\n")' \
	 --eval '(insert ";; Local Variables:\n;; version-control: never\n")' \
	 --eval '(insert ";; no-byte-compile: t\n")' \
	 --eval '(insert ";; coding: utf-8\n;; End:\n;;; org-version.el ends here\n")' \
	 --eval '(save-buffer)'
-include local.mk	# optional local customization

.NOTPARALLEL:	# always run this make serially
.SUFFIXES:	# we don't need default suffix rules
ifeq ($(MAKELEVEL), 0)
  $(error This make needs to be started as a sub-make from the toplevel directory.)
endif

LISPO = org-install.el org-version.el # autogenerated files
LISPF = $(filter-out $(LISPO),$(wildcard *.el))
LISPC = $(LISPF:%el=%elc)

.PHONY:	all compile compile-dirty \
	autoloads \
	install clean cleanauto cleanall clean-install \
	org-version.el

all \
compile \
compile-dirty:	cleanauto org-version.el
	$(ELCDIR)

autoloads:	$(LISPO)

org-version.el:	$(LISPF)
	@echo "org-version: $(ORGVERSION) ($(GITVERSION))"
	@$(ORG-VERSION)

org-install.el:	org-version.el
	$(ORG-INSTALL)

install:	$(LISPF) compile autoloads
	if [ ! -d $(DESTDIR)$(lispdir) ] ; then \
	  $(MKDIR) $(DESTDIR)$(lispdir) ; \
	fi ;
	$(CP) $(LISPC) $(LISPF) $(LISPO) $(DESTDIR)$(lispdir)

clean:
	$(RM) *.elc

cleanauto:	# internal target
	$(RM) $(LISPO) $(LISPO:%el=%elc)

cleanall:
	$(RM) *.elc $(LISPO)

clean-install:
	if [ -d $(DESTDIR)$(lispdir) ] ; then \
	  $(RM) $(DESTDIR)$(lispdir)/org*.el* $(DESTDIR)$(lispdir)/ob*.el* ; \
	fi ;
