# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

is_running()
{
    ps aux | egrep -v "grep $1" | grep "$1" >/dev/null 1>&2
    return $?
}

# Per-system configs
# These will generally have functions to adapt differences between operating systems

sys=`uname -o`
test -f ~/.profile.d/$sys &&  . ~/.profile.d/$sys

# Per-whatever configs
name=`uname -n`
test -f ~/.profile.d/$name &&  . ~/.profile.d/$name

if `grep -F vc.grumpydogconsulting.com /etc/resolv.conf >/dev/null 2>&1`; then
    loc=loc_vc
elif `grep -F "domain ei" /etc/resolv.conf >/dev/null 2>&1`; then
    loc=loc_ei
elif `grep gallifrey /etc/resolv.conf >/dev/null 2>&1`; then
    loc=gallifrey
elif [[ ${USERDOMAIN:-none} = "DS" ]]; then
    loc=extm
elif grep -F tivo.com /etc/resolv.conf >&/dev/null; then
    loc=loc_tv
elif grep -F solekai.com /etc/resolv.conf >&/dev/null; then
    loc=loc_sk
else
    loc=loc_elsewhere
fi

export SSMM_LOC=$loc
test -f ~/.profile.d/$SSMM_LOC &&  . ~/.profile.d/$SSMM_LOC

#. $HOME/.bashrc

is_running ssh-agent || { eval `ssh-agent -s`; echo "eval ssh-agent stuff"; }
#is_running emacs || { emacs --daemon >& ~/.emacsstart.log; }
export EDITOR="emacsclient -c"

# test
