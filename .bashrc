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
    blarf="`echo "$foo" | sed -e 's/^://' -e 's/:$//' -e 's/ /\\ /g'`"
    eval "$lname=\"$blarf\""
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

# Per-location configs
junk=${SSMM_LOC:?}              # Make sure it's defined (from .bash_profile)
test -f ~/.bash.d/$SSMM_LOC &&  . ~/.bash.d/$SSMM_LOC
