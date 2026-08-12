# Let eza use its native Nyx theme without Oh My Zsh's LS_COLORS override.
# Keeping LS_COLORS in the parent shell preserves classic ls and completion.
if (( $+commands[eza] )); then
  export EZA_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/eza"

  eza() {
    LS_COLORS= command eza "$@"
  }
fi
