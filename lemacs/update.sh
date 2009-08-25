# This script should be run on each machine after an update in packages/
# Should be run from ~/lemacs
#
# 'emacs' should invoke the correct emacs

make all

# packages
make -C packages all

# Specials
rsync -av packages/templates/templates/ ${HOME}/.templates

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

