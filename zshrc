# all the hooks for vc and prompt

autoload -Uz compinit promptinit
compinit
promptinit

zstyle ':completion:*' file-list all
zstyle ':completion:*' menu select

autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst

add-zsh-hook precmd vcs_info
PROMPT='%F{red}%n%f@%F{red}%m%f %F{blue}%B%~%b%f %F{red}${vcs_info_msg_0_}%f'$'\n'' > '

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

# exports and aliases
alias ls='ls -G'
alias ll='ls -Gllhr'
alias la='ls -Ga'
alias grep='grep --color'
alias vi='nvim'
alias vim='nvim'
alias v='nvim'

export PATH=/usr/local/bin:$PATH
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export MODULAR_HOME="/Users/joe/.modular"
export PATH="/Users/joe/.modular/pkg/packages.modular.com_max/bin:$PATH"
export EDITOR=nvim
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export CPLUS_INCLUDE_PATH="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/c++/v1:$CPLUS_INCLUDE_PATH"

set -a
source ~/.env
set +a
