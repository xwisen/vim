# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


# User specific aliases and functions

alias rm='rm -iv'
alias mv='mv -iv'
#alias cp='cp -iv'

function vims(){
	fn=$(echo $1 | awk 'BEGIN{FS="/"}{print $NF}END{}')
	cp -rf $1 /tmp/$fn
	vim $1
}
