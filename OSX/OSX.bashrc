#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my BASH configurations and aliases
#
#  Sections:
#  1.  Environment Configuration
#  2.  Make Terminal Better (remapping defaults and adding functionality)
#  3.  File and Folder Management
#  4.  Searching
#  5.  Process Management
#  6.  Networking
#  7.  System Operations & Information
#  8.  Web Development
#  9.  Reminders & Notes
#
#  ---------------------------------------------------------------------------

     if [ -f $HOME/.bash_aliases ]; then
         . $HOME/.bash_aliases
     fi

#   -------------------------------
#   1. ENVIRONMENT CONFIGURATION
#   -------------------------------

#   Change Prompt
#   Generated from: http://ezprompt.net/
#   ------------------------------------------------------------
#    export PS1="\[\e[31m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\][\[\e[34m\]\w\[\e[m\]] \[\e[33m\]\\$\[\e[m\] "
    export PS1="\[\e[31m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\]:\w \[\e[36m\]\\$\[\e[m\] "
    export PS2=" \[\e[36m\]=\[\e[m\]\[\e[36m\]=\[\e[m\]\[\e[36m\]>\[\e[m\]  "

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

#   Set default blocksize for ls, df, du
#   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
#   ------------------------------------------------------------
    export BLOCKSIZE=1k

#   Add color to terminal
#   (this is all commented out as I use Mac Terminal Profiles)
#   from http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
#   ------------------------------------------------------------
#   export CLICOLOR=1
#   export LSCOLORS=ExFxBxDxCxegedabagacad   # for light background
#   export LSCOLORS=GxFxCxDxBxegedabagaced   # for dark background


#   -----------------------------
#   2. MAKE TERMINAL BETTER
#   -----------------------------

#alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
#alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlhp'                        # Preferred 'ls' implementation
alias ls='ls -FGhp'                         # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias vi='vim'
#cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
#alias edit='subl'                           # edit:         Opens any file in sublime editor
alias finder='open -a Finder ./'            # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='type -all'                     # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
alias unix2dos="perl -pe 's/\r\n|\n|\r/\r\n/g'"  # convert a file from unix format to dos format
alias dos2unix="perl -pe 's/\r\n|\n|\r/\n/g'"    # convert a file from dos format to unix format

#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'


#   -------------------------------
#   3. FILE AND FOLDER MANAGEMENT
#   -------------------------------

    alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir

#   cdf:  'Cd's to frontmost window of MacOS Finder
#   ------------------------------------------------------
    cdf () {
        currFolderPath=$( /usr/bin/osascript <<EOT
            tell application "Finder"
                try
            set currFolder to (folder of the front window as alias)
                on error
            set currFolder to (path to desktop folder as alias)
                end try
                POSIX path of currFolder
            end tell
EOT
        )
        echo "cd to \"$currFolderPath\""
        cd "$currFolderPath"
    }

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }


#   ---------------------------
#   4. SEARCHING
#   ---------------------------

    alias qfind="find . -name "      # qfind:    Quickly search for file

#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
    spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }


#   ---------------------------
#   5. PROCESS MANAGEMENT
#   ---------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
    findPid () { lsof -t -c "$@" ; }

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
    alias memHogsTop='top -l 1 -o rsize | head -20'
    alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
    alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
    alias topForever='top -l 9999999 -s 10 -o cpu'

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#       Taken from this macosxhints article
#       http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
    alias ttop="top -R -F -s 10 -o rsize"

#   ---------------------------
#   6. NETWORKING
#   ---------------------------

   alias myip='dig +short myip.opendns.com @resolver1.opendns.com.'    # myip:   Public facing IP Address

#   ---------------------------------------
#   7. SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
    alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

#    screensaverDesktop: Run a screensaver on the Desktop
#   -----------------------------------------------------------------------------------
    alias screensaverDesktop='/System/Library/CoreServices/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'


# Colorize man pages
export LESS_TERMCAP_mb=$'\E[01;31m' # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # end mode
export LESS_TERMCAP_se=$'\E[0m' # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m' # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Environment Settings
shopt -s checkwinsize
export PAGER=/usr/bin/less
export EDITOR=/usr/bin/vim
export LESS="-iMSx4 -FX"
export HISTCONTROL='ignoreboth:erasedupes'
export HISTFILESIZE=10000                    # number of command lines to save in history
export HISTSIZE=1000                         # commands to save in ram
export HISTTIMEFORMAT='%F %T #  '            # add date and timestamp
shopt -s histappend                          # append to history file
export PROMPT_COMMAND='history -a'           # save history after every command
# set screen title
case "$TERM" in
xterm*|rxvt*|linux*)
    export PROMPT_COMMAND='history -a;echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

