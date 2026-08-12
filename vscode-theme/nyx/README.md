# Nyx for VS Code

This is the public, self-contained distribution of the Nyx VS Code theme. It
can be installed from the public dotfiles repository without access to the
private canonical Nyx repository, Node.js, npm, or the VS Code Marketplace.

The theme covers the complete workbench, integrated terminal, Git and diff
views, debugging, tests, notebooks, TextMate syntax scopes, and semantic tokens.
It is intended to work well with Java, Python, TypeScript, Angular, shell,
JSON/YAML/TOML, Markdown, and other languages that use standard VS Code token
roles.

## Install

From a dotfiles checkout at `~/dotfiles`:

```sh
cd "$HOME/dotfiles/vscode-theme/nyx"
shasum -a 256 -c SHA256SUMS
code --install-extension "$HOME/dotfiles/vscode-theme/nyx/nyx-theme.vsix" --force
```

Open **Preferences: Color Theme** (`Cmd+K Cmd+T` on macOS,
`Ctrl+K Ctrl+T` on Linux) and choose **Nyx**.

To select it explicitly in a sanitized VS Code profile:

```json
{
  "workbench.colorTheme": "Nyx",
  "workbench.preferredDarkColorTheme": "Nyx"
}
```

## Update

```sh
git -C "$HOME/dotfiles" pull --ff-only
code --install-extension "$HOME/dotfiles/vscode-theme/nyx/nyx-theme.vsix" --force
```

The JSON theme remains readable beside the VSIX for review. See the
[source and refresh contract](https://github.com/stfolder/dotfiles/blob/main/vscode-theme/nyx/SOURCE.md)
for provenance and maintenance rules.
