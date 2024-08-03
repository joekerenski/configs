# all the hooks for vc and prompt
# add --apple-use-keychain on macos
autoload -Uz compinit promptinit
compinit
promptinit

zstyle ':completion:*' file-list all
zstyle ':completion:*' menu select

autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst

add-zsh-hook precmd vcs_info
PROMPT='%F{red}%n%f@%F{red}%m%f %F{blue}%B%~%b%f %F{red}${vcs_info_msg_0_}%f'$'\n''>>> '

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

export PATH=/usr/local/bin:$PATH
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
