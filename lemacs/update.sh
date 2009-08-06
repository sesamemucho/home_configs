# This script should be run on each machine after an update in packages/
# Should be run from ~/lemacs
#
# 'emacs' should invoke the correct emacs
set -x
here=`pwd`

emacs -batch -q -f batch-byte-compile *el

cp -v dot-emacs ~/.emacs

# misc
cd packages/misc
emacs -batch -q -f batch-byte-compile *el
cd $here

# git-emacs
cd packages/git-emacs
emacs -batch -q -L `pwd` -f batch-byte-compile *el
cd $here

# # BBDB
# cd packages/bbdb
# make clean
# rm -f config.status
# ./configure
# cd lisp
# mv Makefile mk.tmp
# tr -d '\015' <mk.tmp  >Makefile
# rm mk.tmp
# cd ..
# make bbdb gnus
# cd $here

# # org-mode
# cd packages/org
# make clean
# make
# make info
# cd $here

# # remember
# cd packages/remember-1.9
# make clean
# make
# cd $here

# # anything
# cd packages/anything
# emacs -batch -q -L `pwd` -f batch-byte-compile *el
# cd $here

# # Don't forget, the info file 'dir' may need to be updated or created

# # icicles
# cd packages/icicles
# emacs -batch -q -f batch-byte-compile *el
# cd $here

# # emacs-w3m
# cd packages/emacs-w3m
# ./configure --prefix=${HOME}/local
# make
# make install
# make install-icons
# cd $here

# # template
# cd packages/template
# emacs -batch -q -f batch-byte-compile lisp/template.el
# rsync -av templates/ ${HOME}/.templates
# cd $here

# # muse
# cd packages/muse-latest
# make clean
# make
# cd $here
