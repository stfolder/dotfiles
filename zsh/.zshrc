# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="nyx"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

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

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
elif (( $+commands[nvim] )); then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi
export VISUAL="$EDITOR"

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
(( $+commands[nvim] )) && alias vi='nvim' vim='nvim'
(( $+commands[python3] )) && alias python='python3'
(( $+commands[eza] )) && alias ls='eza --icons'
alias brain="cd ~/Brain"
alias proj="cd ~/Projects"
alias work="cd ~/Work"
(( $+commands[kubectl] )) && alias k='kubectl'
(( $+commands[fzf] && $+commands[bat] )) && alias f="fzf --preview='bat --color=always {}'"

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
