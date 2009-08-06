# eventually, From Bash Cookbook
# cookbook filename: func_pathmunge
# Adapted from Red Hat Linux
function listmunge {
    lname=$1
    new_elem=$2
    after_p=$3
    local foo
    foo=${!lname}

    if ! echo ${!lname} | /bin/egrep -q "(^|:)$new_elem($|:)" ; then
        if [[ $after_p = after ]] ; then
            foo="${!lname}:$new_elem"
        else
            foo="${new_elem}:${!lname}"
        fi
    fi

    # In case lname was empty to begin with, trim orphan ':' as appropriate
    eval $lname=`echo $foo | sed -e 's/^://' -e 's/:$//' -e 's/ /\\ /g'`
}


listmunge PATH $HOME/bin
listmunge PATH $HOME/local/bin

#export MANPATH
#listmunge MANPATH $HOME/local/man
#listmunge MANPATH $HOME/local/share/man
#listmunge MANPATH /usr/share/man

# Check for an interactive session
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

PS1='[\u@\h \W]\$ '

alias config='git --git-dir=$HOME/.config.git/ --work-tree=$HOME'

# Per-whatever configs
name=`uname -n`
test -f ~/.bash.d/$name &&  . ~/.bash.d/$name

if `grep gallifrey /etc/resolv.conf >/dev/null 2>&1`; then
    loc=gallifrey
elif `grep -F vc.grumpydogconsulting /etc/resolv.conf >/dev/null 2>&1`; then
    loc=vc
elif [[ ${USERDOMAIN:-none} = "DS" ]]; then
    loc=extm
else
    loc=elsewhere
fi
test -f ~/.bash.d/$loc &&  . ~/.bash.d/$loc

