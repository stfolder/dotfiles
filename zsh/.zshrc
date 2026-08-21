# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="nyx"

HISTSIZE=999
SAVEHIST=1000

plugins=(git python pyenv virtualenv pip poetry fzf)

# Load optional custom plugins only when they are installed on this machine.
for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
  [[ -d "${ZSH_CUSTOM:-$ZSH/custom}/plugins/$plugin" ]] && plugins+=("$plugin")
done
unset plugin

# Support both a standard nvm install and Homebrew on Apple Silicon.
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
for nvm_script in "$NVM_DIR/nvm.sh" /opt/homebrew/opt/nvm/nvm.sh; do
  if [[ -s "$nvm_script" ]]; then
    source "$nvm_script"
    break
  fi
done
for nvm_completion in "$NVM_DIR/bash_completion" /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm; do
  if [[ -s "$nvm_completion" ]]; then
    source "$nvm_completion"
    break
  fi
done
unset nvm_script nvm_completion

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions.
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
elif (( $+commands[nvim] )); then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi
export VISUAL="$EDITOR"

(( $+commands[nvim] )) && alias vi='nvim' vim='nvim'
(( $+commands[python3] )) && alias python='python3'
(( $+commands[eza] )) && alias ls='eza --icons'
alias brain="cd ~/Brain"
alias proj="cd ~/Projects"
alias work="cd ~/Work"
(( $+commands[kubectl] )) && alias k='kubectl'
(( $+commands[fzf] && $+commands[bat] )) && alias f="fzf --preview='bat --color=always {}'"

# zoxide provides a learned `z` directory jump while keeping normal `cd` intact.
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

# Yazi remains a normal command. The `y` wrapper additionally returns the shell
# to the directory selected when Yazi exits.
if (( $+commands[yazi] )); then
  y() {
    local tmp cwd
    tmp="$(mktemp -t 'yazi-cwd.XXXXXX')" || return
    command yazi "$@" --cwd-file="$tmp"
    cwd="$(command cat -- "$tmp" 2>/dev/null)"
    rm -f -- "$tmp"
    [[ -n "$cwd" && "$cwd" != "$PWD" ]] && builtin cd -- "$cwd"
  }
fi

# Home WireGuard shortcuts are available only where the tools are installed.
if (( $+commands[wg-quick] && $+commands[wg] )); then
  wg-home-up() {
    sudo "${commands[wg-quick]}" up "$HOME/.wireguard/home-platform/wg-home-trusted.conf"
  }
  wg-home-down() {
    sudo "${commands[wg-quick]}" down "$HOME/.wireguard/home-platform/wg-home-trusted.conf"
  }
  wg-home-status() {
    sudo "${commands[wg]}" show
  }
fi

# Keep optional toolchains quiet on machines where they are not installed.
typeset -U path PATH
export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"
[[ -d "$PYENV_ROOT/bin" ]] && path=("$PYENV_ROOT/bin" $path)
(( $+commands[pyenv] )) && eval "$(pyenv init --path)"

for optional_bin in \
  "$HOME/.antigravity/antigravity/bin" \
  "$HOME/Developer/bin"; do
  [[ -d "$optional_bin" ]] && path+=("$optional_bin")
done
unset optional_bin

# Bun is optional and installs under the home directory on macOS and Linux.
if [[ -d "$HOME/.bun" ]]; then
  [[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"
  export BUN_INSTALL="$HOME/.bun"
  path=("$BUN_INSTALL/bin" $path)
fi

# Private or machine-only additions can live here without entering Git.
[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
