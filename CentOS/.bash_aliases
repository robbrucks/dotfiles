#   ------------------------------------------------------------
#   Useful Aliases on OSX
#   ------------------------------------------------------------
alias ~="cd ~"                              # ~:            Go Home
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias c='clear'                             # c:            Clear terminal display
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
#alias cp='cp -iv'                           # Preferred 'cp' implementation
alias dos2unix="perl -pe 's/\r\n|\n|\r/\n/g'"    # convert a file from dos format to unix format
#alias edit='subl'                           # edit:         Opens any file in sublime editor
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias grep='grep --color=auto'
alias l.='ls -AFlhp --color=auto'           # List hidden files
alias l='ls -Flhp --color=auto'             # Preferred 'ls' implementation
alias ll='ls -Flhp --color=auto'            # Preferred 'ls' implementation
#                                             lr:  Full Recursive Directory Listing
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
alias ls='ls -Fhp --color=auto'                         # Preferred 'ls' implementation
#alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias myip='dig +short myip.opendns.com @resolver1.opendns.com.'    # myip:   Public facing IP Address
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias qfind="find . -name "                 # qfind:        Quickly search for file
alias rm='rm -I --preserve-root'            # rm:           A safer rm
alias show_options='shopt'                  # Show_options: display bash options settings
alias unix2dos="perl -pe 's/\r\n|\n|\r/\r\n/g'"  # convert a file from unix format to dos format
alias vi='vim'


#   ------------------------------------------------------------
#   Function-based Aliases
#   ------------------------------------------------------------

# cd () { builtin cd "$@"; ls -l; }               # Always list directory contents upon 'cd'


# extract:  Extract most know archives with one command
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



