#
# Makefile to rebuild my (downloaded) elisp files
#

#modules := misc git-emacs templates/lisp versor/lisp
#modules := misc git-emacs templates/lisp python
modules := misc templates/lisp python

source  := $(foreach mod,$(modules),$(wildcard $(mod)/*.el))
objects := $(subst .el,.elc,$(source))
deps    := $(subst .el,.d,$(source))

modlist := $(addprefix -L $(PWD)/,$(modules))

gather_file := .gather.d

ECHO	:= echo
EMACS	:= emacs
TOUCH	:= touch
RM      := rm -f

.PHONY: prelim gather

all: gather prelim
	$(EMACS) -batch -q $(modlist) -f batch-byte-compile `cat $(gather_file)`
	@ $(RM) $(gather_file)

gather: $(objects)

prelim:
	@ $(TOUCH) $(gather_file) # Make sure it's there

clean:
	$(RM) $(objects)
	$(RM) $(gather_file)

%.elc: %.el
	@ $(ECHO) $< >>$(gather_file)
