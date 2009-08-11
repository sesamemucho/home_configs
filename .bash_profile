# Per-system configs
# These will generally have functions to adapt differences between operating systems

sys=`uname -o`
test -f ~/.profile.d/$sys &&  . ~/.profile.d/$sys

is_running ssh-agent || { eval `ssh-agent -s`; }
is_running emacs || { emacs --daemon >& ~/.emacsstart.log; }
export EDITOR="emacsclient -c"

# Per-whatever configs
name=`uname -n`
test -f ~/.profile.d/$name &&  . ~/.profile.d/$name

if `grep gallifrey /etc/resolv.conf >/dev/null 2>&1`; then
    loc=gallifrey
elif `grep -F vc.grumpydogconsulting /etc/resolv.conf >/dev/null 2>&1`; then
    loc=vc
else
    loc=elsewhere
fi
test -f ~/.profile.d/$loc &&  . ~/.profile.d/$loc

. $HOME/.bashrc

# test
