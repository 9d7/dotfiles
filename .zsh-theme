PROMPT_SSH_PREFIX=""
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    PROMPT_SSH_PREFIX='%F{8}%M %b%f%F{red}♥ '
fi

function prompt_precmd() {
    RETVAL="$?"

    PROMPT_DIR="%F{3}%B%~ %b%f"

    PROMPT_RETVAL=
    if [ $RETVAL -ne 0 ]; then
        PROMPT_RETVAL="%F{red}« %B$RETVAL%b%f"
    fi

    CURRENT_GIT_BRANCH=`git branch --show-current 2>/dev/null`
    PROMPT_GIT=
    if [ -n "$CURRENT_GIT_BRANCH" ]; then
        PROMPT_GIT="%F{5} $CURRENT_GIT_BRANCH%f"
    fi

    PROMPT_TIME="%F{7}  %D{%L:%M:%S}%f"

    export RPROMPT="$PROMPT_RETVAL$PROMPT_TIME"
    export PROMPT="$PROMPT_SSH_PREFIX$PROMPT_DIR$PROMPT_GIT"$'\n'"%F{green}%n %F{blue}»%f "
}

autoload -Uz add-zsh-hook
add-zsh-hook -d precmd prompt_precmd
add-zsh-hook precmd prompt_precmd
