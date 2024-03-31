eval "$(/opt/homebrew/bin/brew shellenv)"
export DEV_ENV_NAME=kekido
export MANPAGER='nvim +Man! -'
export GIT_CONFIG_GLOBAL=$HOME/.config/git/.gitconfig
export DOTCONFIG_PATH=$HOME/.config
export GOPATH=$HOME/gocode
export PATH=/usr/bin:$HOME/bin:$HOME/bin/institutions:/usr/local/bin:$HOME/.rbenv/bin:$HOME/.local/bin:$PATH:$GOPATH/bin:$HOME/Projects/data-aggregation-utils/bin:$HOME/.pyenv/shims:${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/bin:/usr/local/anaconda3/bin:$PATH:$HOME/.config/bin
export PATH="$PATH:opt/homebrew/bin"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/.cargo/env"
export PATH="$PATH:$HOME/Library/Python/3.9/bin"
export ZSH_CUSTOM=$HOME/.config/oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="agnoster"
export PGDATA=/usr/local/var/postgresql@16
export NIX_PATH=${NIX_PATH:+$NIX_PATH:}$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export EDITOR="vim"
export GIT_EDITOR="vim"
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export HOMEBREW_BUNDLE_FILE=$HOME/.config/brew/Brewfile

plugins=(git rbenv ruby bundler rake)
source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

# alias
## system
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
## docker
alias dcu='docker-compose up'
alias dcd='docker-compose down --volumes'
## ruby
alias rake='noglob bundled_rake'
## brew
alias bdump='brew bundle dump --force'
alias bbundle='brew bundle'
alias ncd='cd /etc/nix'

# commands
function restart() {
  source $HOME/.config/zsh/.zshrc
}

## tabtab source for packages
## uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

## Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
## End Nix

