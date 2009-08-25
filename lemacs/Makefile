#
# Makefile to rebuild my (downloaded) elisp files
#

#modules := misc git-emacs templates/lisp versor/lisp
modules  := .

source   := $(wildcard *.el)
objects  := $(subst .el,.elc,$(source))
dotfiles := $(HOME)/.emacs

gather_file := .gather.d

CP	 := cp -v
ECHO	 := echo
EMACS	 := emacs
TOUCH	 := touch
RM       := rm -f

.PHONY: prelim gather

all: gather $(dotfiles) prelim
	$(EMACS) -batch -q -f batch-byte-compile `grep -F ssmm-config $(gather_file)`
	$(EMACS) -batch -q --load=ssmm-config.elc -f batch-byte-compile `egrep -v ssmm-config $(gather_file)`
	@ $(RM) $(gather_file)

gather: $(objects)

prelim:
	@ $(TOUCH) $(gather_file) # Make sure it's there

clean:
	$(RM) $(objects)
	$(RM) $(gather_file)

%.elc: %.el
	@ $(ECHO) $< >>$(gather_file)

$(HOME)/.emacs: dot-emacs
	@ $(CP) $< $@
