is_running()
{
    ps aux | egrep -v "grep $1" | grep "$1" &>/dev/null
    return $?
}

# Per-system configs
# These will generally have functions to adapt differences between operating systems

sys=`uname -o`
test -f ~/.profile.d/$sys &&  . ~/.profile.d/$sys

# Per-whatever configs
name=`uname -n`
test -f ~/.profile.d/$name &&  . ~/.profile.d/$name

if `grep gallifrey /etc/resolv.conf >/dev/null 2>&1`; then
    loc=gallifrey
elif [[ ${USERDOMAIN:-none} = "DS" ]]; then
    loc=extm
else
    # Home base
    loc=vc
fi

export SSMM_LOC=$loc
test -f ~/.profile.d/$SSMM_LOC &&  . ~/.profile.d/$SSMM_LOC

. $HOME/.bashrc

is_running ssh-agent || { eval `ssh-agent -s`; }
is_running emacs || { emacs --daemon >& ~/.emacsstart.log; }
export EDITOR="emacsclient -c"

# test
