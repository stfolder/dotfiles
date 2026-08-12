# Nyx — Oh My Zsh
# Canonical palette: stfolder/nyx themes/nyx/palette.toml

setopt prompt_subst

# The theme renders virtual environments itself, beside the Git context.
export VIRTUAL_ENV_DISABLE_PROMPT=1

nyx_prompt_context() {
  if [[ -n "$SSH_CONNECTION" || EUID -eq 0 ]]; then
    local color="#7DCFFF"
    (( EUID == 0 )) && color="#F2778F"
    print -nr -- "%F{${color}}%n@%m%f %F{#665D82}in%f "
  fi
}

nyx_prompt_python_env() {
  local env_name=""

  if [[ -n "$VIRTUAL_ENV" ]]; then
    env_name="${VIRTUAL_ENV:t}"
  elif [[ -n "$CONDA_DEFAULT_ENV" && "$CONDA_DEFAULT_ENV" != "base" ]]; then
    env_name="$CONDA_DEFAULT_ENV"
  fi

  [[ -n "$env_name" ]] || return 0
  env_name="${env_name//\%/%%}"
  print -nr -- " %F{#665D82}via%f %F{#74D3C4}${env_name}%f"
}

# Git uses violet for identity and peach only when attention is needed.
ZSH_THEME_GIT_PROMPT_PREFIX=" %F{#665D82}on%f %F{#B69CFF} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{#EF9F76} ●%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Two lines keep long local and remote paths readable. The final glyph reflects
# the previous command: violet for success, Nyx red for failure.
PROMPT='%F{#665D82}╭─%f $(nyx_prompt_context)%F{#A9A0FF}%3~%f$(git_prompt_info)$(nyx_prompt_python_env)
%F{#665D82}╰─%f %(?.%F{#B69CFF}.%F{#F2778F})❯%f '

# Failure details and background jobs stay visible without crowding the prompt.
RPROMPT='%(?..%F{#F2778F}exit %?%f)%(1j. %F{#7DCFFF}%j jobs%f.)'
