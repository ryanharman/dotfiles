# Path to your Oh My Zsh installation (required for antidote's use-omz)
export ZSH="$HOME/.oh-my-zsh"

# OMZ configuration (applied before antidote loads OMZ)
zstyle ':omz:update' mode reminder
DISABLE_AUTO_TITLE="true"

# Preferred editor
export EDITOR='nvim'

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

# NVM lazy loading - only loads when nvm/node/npm/npx/yarn is called
export NVM_DIR="$HOME/.nvm"
nvm_lazy_load() {
  unset -f nvm node npm npx yarn
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
nvm() { nvm_lazy_load; nvm "$@"; }
node() { nvm_lazy_load; node "$@"; }
npm() { nvm_lazy_load; npm "$@"; }
npx() { nvm_lazy_load; npx "$@"; }
yarn() { nvm_lazy_load; yarn "$@"; }

# sst
export PATH=$HOME/.sst/bin:$PATH

# python env
alias python=/usr/bin/python3

# antidote (zsh plugin manager)
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load $HOME/repos/dotfiles/.zsh_plugins

# pipx
export PATH="$PATH:$HOME/.local/bin"
