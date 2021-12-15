setopt GLOB_DOTS
bindkey -e

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTCONTROL=ignoreboth:erasedups
export SAVEHIST=9999999
export HISTSIZE=9999999
export HISTFILE="$HOME/.zsh_hist"
setopt appendhistory

# Make nano the default editor

export EDITOR='nvim'
export VISUAL='nvim'

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

export SCRIPT_DIR="$HOME/scripts"
export LS_COLORS="$LS_COLORS:ow=1;94";

# my scripts! :)
[ -n "$(ls -A $SCRIPT_DIR 2>/dev/null)" ] && {
    for file in $SCRIPT_DIR/*.zsh; do
        chmod +x $file;
        alias ${file:t:r}=". ${file}";
    done
}

[ -n "$(ls -A $SCRIPT_DIR/autorun 2>/dev/null)" ] && {
    for file in $SCRIPT_DIR/autorun/*.zsh; do
        chmod +x $file;
        . ${file};
    done
}

#list
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -la'
alias l='ls'
alias l.="ls -A | egrep '^\.'"

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

#continue download
alias wget="wget -c"

#merge new settings
alias merge="xrdb -merge ~/.Xresources"

# paru as aur helper - updates everything
alias pksyua="paru -Syu --noconfirm"
alias upall="paru -Syu --noconfirm"

#ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"

#search content with ripgrep
alias rg="rg --sort path"

alias todo="$EDITOR ~/todo.txt"

# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# theming
source ~/.zsh-theme
export BAT_THEME="fly16"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
