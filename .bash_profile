# Per-system configs
# These will generally have functions to adapt differences between operating systems

sys=`uname -o`
test -f ~/.profile.d/$sys &&  . ~/.profile.d/$sys

is_running ssh-agent || { eval `ssh-agent -s`; }
is_running gpg-agent || { gpg-agent --daemon --enable-ssh-support -v -v --log-file=${HOME}/g.log \
    --write-env-file "${HOME}/.gpg-agent-info"; }

if [ -f "${HOME}/.gpg-agent-info" ]; then
    . "${HOME}/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
    export SSH_AGENT_PID
fi

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
