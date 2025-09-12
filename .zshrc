# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Custom prompt of `filepath | git_branch`
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f | %F{red}${vcs_info_msg_0_}%f$ '

# Aliases
alias ga="git add"
alias gs="git status"
alias gc="git commit"
alias gch="git checkout"
alias gp="git push origin"
alias gr="git pull --rebase origin"
alias gb="git branch"
alias lines="git ls-files | xargs cat | wc -l"
alias nv="nvim"
alias rebase-main='git fetch origin main && git rebase origin/main'

dotfiles="$HOME/repos/dotfiles"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# sst
export PATH=$HOME/.sst/bin:$PATH

# python env
alias python=/usr/bin/python3

# antidote (zsh plugin manager)
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load $HOME/repos/dotfiles/.zsh_plugins

# Created by `pipx` on 2025-09-02 08:52:08
export PATH="$PATH:/Users/ryanharman/.local/bin"
