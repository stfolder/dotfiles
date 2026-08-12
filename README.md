# Nyx terminal dotfiles

A portable, dark terminal setup for macOS and Linux. Kitty provides the local
terminal, tmux keeps the same session and pane workflow locally and over SSH,
and the Nyx palette ties Kitty, tmux, Oh My Zsh, and eza together.

The canonical palette and design rules live in
[`stfolder/nyx`](https://github.com/stfolder/nyx). This repository contains the
ready-to-install terminal themes and configuration.

## What is included

| Stow package | Installed path | Purpose |
| --- | --- | --- |
| `kitty` | `~/.config/kitty` | Cross-platform Kitty config and Nyx theme |
| `tmux` | `~/.tmux.conf`, `~/.tmux/themes` | Shared local/remote tmux workflow and status theme |
| `omz` | `~/.oh-my-zsh/custom` | Nyx prompt and eza color integration |
| `eza` | `~/.config/eza` | Nyx file-type and metadata colors |
| `zsh` | `~/.zshrc` | Active Oh My Zsh setup and guarded optional tools |

GNU Stow creates symlinks from these package directories into your home
directory. The repository remains the source of truth, so updates stay easy to
review and reuse on another machine.

## 1. Install the prerequisites

Every machine needs Git, [GNU Stow](https://www.gnu.org/software/stow/), Zsh,
tmux, and [eza](https://eza.rocks/). A graphical workstation also needs
[Kitty](https://sw.kovidgoyal.net/kitty/) and the JetBrains Mono Nerd Font.
Oh My Zsh and TPM are installed in later steps.

### macOS

Install [Homebrew](https://brew.sh/) first, then run:

```sh
brew install git stow tmux eza
brew install --cask kitty font-jetbrains-mono-nerd-font
```

macOS already includes Zsh. If Homebrew is not available in a new terminal,
add the `brew shellenv` line printed by the Homebrew installer to `~/.zprofile`.
That file is intentionally machine-specific and is not managed here.

### Linux

Install Git, Stow, Zsh, tmux, and eza with your distribution's package manager.
Use a packaged Kitty build when it is current enough, or use Kitty's
[official binary installer](https://sw.kovidgoyal.net/kitty/binary/):

```sh
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

Install JetBrains Mono Nerd Font from your distribution, or download it from
[Nerd Fonts](https://www.nerdfonts.com/font-downloads). Kitty must see the font
as `JetBrainsMono Nerd Font`.

## 2. Install Oh My Zsh

Install Oh My Zsh before linking the dotfiles so its installer cannot replace
the managed `~/.zshrc`:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

The setup expects Oh My Zsh at its standard path, `~/.oh-my-zsh`. To make Zsh
your login shell when needed:

```sh
chsh -s "$(command -v zsh)"
```

Log out and back in if the login-shell change does not take effect immediately.

## 3. Clone and link the dotfiles

```sh
git clone https://github.com/stfolder/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Stow will stop rather than overwrite an existing config. On a machine with
existing terminal files, move them into a dated backup first:

```sh
backup="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup/.config"
[ ! -e "$HOME/.zshrc" ] || mv "$HOME/.zshrc" "$backup/"
[ ! -e "$HOME/.tmux.conf" ] || mv "$HOME/.tmux.conf" "$backup/"
[ ! -e "$HOME/.config/kitty" ] || mv "$HOME/.config/kitty" "$backup/.config/"
[ ! -e "$HOME/.config/eza" ] || mv "$HOME/.config/eza" "$backup/.config/"
```

Create the symlinks:

```sh
stow --target="$HOME" kitty tmux omz eza zsh
```

This links only the five packages above. Other packages in the repository are
independent and are not required for the Nyx terminal setup.

### Forge or another headless server

Keep Kitty and the Nerd Font on the local workstation; they do not need to be
installed on a remote server. After installing the command-line prerequisites,
Oh My Zsh, and cloning this repository on the server, link only this subset:

```sh
cd ~/dotfiles
stow --target="$HOME" tmux omz eza zsh
```

The local Kitty window still renders the colors and font. The remote tmux config
keeps the same keys, Nyx status line, 1-based numbering, and graphics
passthrough when the remote tool and connection support it.

## 4. Install tmux plugins

[TPM](https://github.com/tmux-plugins/tpm) installs the tmux navigator and the
Catppuccin status-line renderer used by the Nyx theme:

```sh
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
"$HOME/.tmux/plugins/tpm/bin/install_plugins"
```

You can also start tmux and press `prefix` + <kbd>I</kbd> (capital i) to install
the plugins. The default prefix remains <kbd>Ctrl</kbd>+<kbd>b</kbd>.

Finally, restart Kitty or reload the active programs:

```sh
exec zsh
tmux source-file "$HOME/.tmux.conf"
```

## 5. Install the VS Code theme

The Nyx VS Code extension lives with the canonical palette in
[`stfolder/nyx`](https://github.com/stfolder/nyx/tree/main/themes/nyx/vscode).
It is deliberately separate from machine-specific editor settings. Install
[Node.js](https://nodejs.org/), npm, and the VS Code `code` command, then run:

```sh
git clone https://github.com/stfolder/nyx.git "$HOME/nyx"
cd "$HOME/nyx/themes/nyx/vscode"
npm ci
npm run install:local
```

Open **Preferences: Color Theme** (`Cmd+K Cmd+T` on macOS,
`Ctrl+K Ctrl+T` on Linux) and choose **Nyx**. To select it explicitly in a
sanitized VS Code profile:

```json
{
  "workbench.colorTheme": "Nyx",
  "workbench.preferredDarkColorTheme": "Nyx"
}
```

On a work machine, install the theme package or import only the sanitized
profile. Keep company extensions, credentials, repository settings, and other
work configuration outside the personal repositories and Settings Sync.

## Theme and workflow behavior

- Kitty opens or attaches to the tmux session named `base`. Detaching from tmux
  returns to a normal login shell instead of closing the Kitty window.
- tmux windows and panes start at 1, mouse support is enabled, and terminal
  passthrough is enabled for modern protocols such as Kitty graphics.
- Kitty uses 90% opacity on both platforms. macOS also gets background blur;
  Linux blur is left to the compositor so the shared config remains portable.
- On macOS, left Option acts as Alt while right Option remains available for
  normal macOS characters.
- eza uses its native Nyx theme without replacing `LS_COLORS` for classic `ls`
  or shell completion. The `ls` alias uses `eza --icons` when eza is installed.
- Machine-private shell additions belong in `~/.zshrc.local`; that file is not
  tracked by this repository.

The Zsh config safely skips optional tools that are absent. If installed, it
also recognizes `zsh-autosuggestions`, `zsh-syntax-highlighting`, NVM, pyenv,
Bun, fzf with bat previews, kubectl, and the local WireGuard helpers.

To reproduce the two optional Zsh plugins used on the main Mac:

```sh
custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git clone https://github.com/zsh-users/zsh-autosuggestions "$custom/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$custom/plugins/zsh-syntax-highlighting"
exec zsh
```

The `ls` alias selects eza, while `command ls` remains available whenever the
classic tool is the better fit.

## Verify the setup

```sh
readlink "$HOME/.zshrc"
echo "$ZSH_THEME"                         # nyx
tmux show-options -gv base-index          # 1
tmux show-options -gv allow-passthrough   # on
eza --long --git
```

Open an image with a Kitty graphics-aware tool, for example Kitty's built-in
icat kitten:

```sh
kitten icat path/to/image.png
```

It should render both directly in Kitty and inside the configured tmux version.

## Update

```sh
git -C "$HOME/dotfiles" pull --ff-only
stow --restow --dir="$HOME/dotfiles" --target="$HOME" kitty tmux omz eza zsh
"$HOME/.tmux/plugins/tpm/bin/update_plugins" all
exec zsh
```

Restart Kitty after changes to its configuration. Existing tmux sessions can
reload with `prefix` + <kbd>r</kbd>.

Update and reinstall the VS Code theme separately:

```sh
git -C "$HOME/nyx" pull --ff-only
cd "$HOME/nyx/themes/nyx/vscode"
npm ci
npm run install:local
```

## Remove the symlinks

This removes only the Stow-managed links; it does not delete the repository or
your backup:

```sh
stow --delete --dir="$HOME/dotfiles" --target="$HOME" kitty tmux omz eza zsh
```
