# GENERAL {{{

    HYPHEN_INSENSITIVE="true"

    CASE_SENSITIVE="false"

    ENABLE_CORRECTION="true"

    DISABLE_LS_COLORS="false"

    export EDITOR="nvim"

    export TERM="xterm-256color"

# }}}
# POWERLEVEL9K {{{

    # sets the way pl9k handles the font
    POWERLEVEL9K_MODE="awesome-fontconfig"

    # new line after prompt
    POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
    POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
    POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=" : "

    # null segment separators
    POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=""
    POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=""
    POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=""
    POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=""

    # "dir_writable" segment
    POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="clear"
    POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="yellow"

    # "dir" segment
    POWERLEVEL9K_DIR_HOME_BACKGROUND="clear"
    POWERLEVEL9K_DIR_HOME_FOREGROUND="blue"
    POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear"
    POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="blue"
    POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="clear"
    POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

    # "command_execution_time" segment
    POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND="clear"
    POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="green"

    # "vcs" segment (git)
    POWERLEVEL9K_VCS_CLEAN_FOREGROUND="green"
    POWERLEVEL9K_VCS_CLEAN_BACKGROUND="clear"
    POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="magenta"
    POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="clear"
    POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="red"
    POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="clear"

    # "status" segment
    POWERLEVEL9K_STATUS_OK_BACKGROUND="clear"
    POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
    POWERLEVEL9K_STATUS_ERROR_BACKGROUND="clear"
    POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"

    # "virtualenv" segment
    POWERLEVEL9K_VIRTUALENV_BACKGROUND="clear"
    POWERLEVEL9K_VIRTUALENV_FOREGROUND="green"

    # print execution_time if threshold >= 3
    POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=2

    # terminal prompt in new line
    POWERLEVEL9K_PROMPT_ON_NEWLINE=true

    # left elements/segments
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status dir_writable dir)

    # right elements/segments
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time virtualenv vcs)

# }}}
# OH-MY-ZSH {{{

    export ZSH="$HOME/.oh-my-zsh"

    # update frequency
    export UPDATE_ZSH_DAYS=7

    # theme definition
    ZSH_THEME="powerlevel10k/powerlevel10k"

    # plugin definition
    plugins=(
        git
        encode64
        vi-mode
        urltools
        python
        pip
        zsh-autosuggestions
        zsh-syntax-highlighting
    )

    # source oh-my-zsh
    source "$ZSH/oh-my-zsh.sh"

    # allows using option/alt-v to open vim and edit the shell command
    autoload edit-command-line
    zle -N edit-command-line
    bindkey -M vicmd v edit-command-line

# }}}
# FUNCTIONS {{{

    # create a job that doesn't depend on zsh
    mjob() {
        nohup "$@" & disown
    }

    # create a dir (with parents) and cd into them
    m() {
        mkdir -p -- "$1" &&
            cd -P -- "$1" || return
    }

# }}}
# ALIASES {{{

    # programs
    alias b="bat"
    alias c="clear"
    alias v="nvim"
    alias ll="exa --long --header --sort type --reverse --git --group"
    alias l="ll --all"
    alias llt="ll --tree"
    alias lt="l --tree"
    alias poe="poetry run poe"

# }}}
# GITPOD CONFIG {{{

    for i in $(ls -A $HOME/.bashrc.d/); do
        source $HOME/.bashrc.d/$i;
    done

# }}}
# PATH {{{

    CUSTOM_BIN_PATH="$HOME/bin"
    GOLANG_PATH="$HOME/go/bin"
    RVM_PATH="$HOME/.rvm/bin"

    CUSTOM_PATH="$CUSTOM_BIN_PATH:$GOLANG_PATH:$RVM_PATH"

    export PATH="$CUSTOM_PATH:$PATH"

    # remove duplicated path segments
    typeset -U path

# }}}
