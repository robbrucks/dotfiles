#   ------------------------------------------------------------
#   Import custom aliases, if they exist
#   ------------------------------------------------------------

if [ -f $HOME/.bash_aliases ]; then
  source $HOME/.bash_aliases
fi


#   ------------------------------------------------------------
#   Set Paths
#   ------------------------------------------------------------

export PATH="$PATH:/usr/local/sbin:/usr/local/bin"

if [[ -d $HOME/.local/bin ]]; then
  export PATH="$PATH:$HOME/.local/bin"
fi
if [[ -d $HOME/.bin ]]; then
  export PATH="$PATH:$HOME/.bin"
fi
if [[ -d $HOME/bin ]]; then
  export PATH="$PATH:$HOME/bin"
fi


#   ------------------------------------------------------------
#   Set Prompt
#   Generated from: http://ezprompt.net/
#   ------------------------------------------------------------

# get current branch in git repo
function parse_git_branch() {
    rc=$?   # save rc for use in ps1
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
        REPODIR=`git rev-parse --show-toplevel`
        REPONAME=`basename ${REPODIR}`
		echo " [${REPONAME}:${BRANCH}${STAT}]"
        return $rc
	else
		echo ""
        return $rc
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo "${bits}"
	else
		echo ""
	fi
}



#   ------------------------------------------------------------
#   Add color to terminal
#   (this is all commented out as I use Mac Terminal Profiles)
#   from http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
#   ------------------------------------------------------------
# export CLICOLOR=1
# export LSCOLORS=ExFxBxDxCxegedabagacad   # for light background
# export LSCOLORS=GxFxCxDxBxegedabagaced   # for dark background


#   ------------------------------------------------------------
#   Colorize man pages
#   ------------------------------------------------------------
export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode – red
export LESS_TERMCAP_md=$(printf '\e[01;35m') # enter double-bright mode – bold, magenta
export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode
export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode – yellow
export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;36m') # enter underline mode – cyan 


#   ------------------------------------------------------------
#   Bash Settings
#   ------------------------------------------------------------
shopt -s checkwinsize
shopt -s histappend                          # append to history file
shopt -s nocaseglob

#   ------------------------------------------------------------
#   Environment Settings
#   ------------------------------------------------------------
export BLOCKSIZE=1k                          # set blocksize shown for ls, df, du
export EDITOR=/usr/bin/vim                   # set default editor to vim
export HISTCONTROL='ignoreboth:erasedupes'   # remove dupes and "spaced" commands from history
export HISTFILESIZE=10000                    # number of command lines to save in history
export HISTSIZE=1000                         # commands to save in ram
export HISTTIMEFORMAT='%F %T #  '            # add date and timestamp
export LESS='-FiMRSXx4'                      # make less less annoying
export PAGER=/usr/bin/less                   # set default pager to less

#   ------------------------------------------------------------
#   Enable tab completion for ssh, scp, and sftp hostnames
#   ------------------------------------------------------------
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;


#   ------------------------------------------------------------
#   Set screen title and save history at every prompt
#   ------------------------------------------------------------
case "$TERM" in
xterm*|rxvt*|linux*)
    export PROMPT_COMMAND='history -a;echo -ne "\033]0;${HOSTNAME%%.*}: ${PWD/$HOME/~}\007"'
    export PS1="\[\033[38;5;15m\][\[$(tput sgr0)\]\[\033[38;5;214m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;12m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;11m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]]\[$(tput sgr0)\]\[\033[38;5;15m\]\`parse_git_branch\`\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;9m\](\$?)\[$(tput sgr0)\]\[\033[38;5;13m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
    export PS2=" \[\033[38;5;3m\]==>\[$(tput sgr0)\] "
    ;;
screen*)
    export PROMPT_COMMAND='history -a'
    export PS1="[]\[\033[38;5;15m\][\[$(tput sgr0)\]\[\033[38;5;214m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;12m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;11m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]]\[$(tput sgr0)\]\[\033[38;5;15m\]\`parse_git_branch\`\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;9m\](\$?)\[$(tput sgr0)\]\[\033[38;5;13m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
    export PS2=" \[\033[38;5;3m\]==>\[$(tput sgr0)\] "
    ;;
*)
    export PROMPT_COMMAND='history -a'
    ;;
esac

