# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# HIST_STAMPS="mm/dd/yyyy"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

alias g='/usr/bin/git'
alias setup-venv='python -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt'

export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

SYSTEM="$(uname -s)"

if [ $SYSTEM = "Darwin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # Add Visual Studio Code (code)
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

# home-git
alias home-git='/usr/bin/git --git-dir=$HOME/.home-git/ --work-tree=$HOME'

# Created by `pipx` on 2023-07-27 08:43:39
export PATH="$PATH:$HOME/.local/bin"

# gems
if [ -d "$HOME/.rbenv" ]; then
  # export PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin"
  export PATH="$PATH:$HOME/.rbenv/bin"
  eval "$(rbenv init -)"
fi

# use KDE's file dialog instead of GTK's
export GTK_USE_PORTAL=1

if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# flutter and android
if [ -d "$HOME/.flutter" ]; then
  export PATH="$PATH:$HOME/.flutter/flutter"
  export PATH="$PATH:$HOME/.flutter/flutter/bin"
fi

if [ $SYSTEM = "Darwin" ]; then
  alias python='python3'
fi

if [ -d "$HOME/.cargo" ]; then
  . "$HOME/.cargo/env"
fi

if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
fi

if [ $SYSTEM = "Darwin" ]; then
  _direnv_hook() {
    trap -- '' SIGINT
    eval "$("/opt/homebrew/bin/direnv" export zsh)"
    trap - SIGINT
  }
  typeset -ag precmd_functions
  if (( ! ${precmd_functions[(I)_direnv_hook]} )); then
    precmd_functions=(_direnv_hook $precmd_functions)
  fi
  typeset -ag chpwd_functions
  if (( ! ${chpwd_functions[(I)_direnv_hook]} )); then
    chpwd_functions=(_direnv_hook $chpwd_functions)
  fi

  export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
fi

# Disabled because it is only for macos and may not be needed anymore
# export JAVA_HOME=$(/usr/libexec/java_home -v 17)
# export PATH=$JAVA_HOME/bin:$PATH

# Increase file descriptor limit
ulimit -n 2048
eval "$(direnv hook zsh)"
