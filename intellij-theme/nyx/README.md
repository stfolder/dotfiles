# Nyx for IntelliJ Platform IDEs

Nyx is a dark-indigo application theme and editor color scheme for IntelliJ
IDEA and other IntelliJ Platform IDEs. Its syntax roles deliberately match the
Nyx VS Code theme, so Java or Spring work keeps the same visual grammar when it
moves between editors.

## Syntax contract

| Semantic role | Nyx color | Hex |
| --- | --- | --- |
| Normal text and variables | Text | `#DAD6EB` |
| Comments | Overlay 1, italic | `#81799C` |
| Keywords and control flow | Pink | `#E6A6D7` |
| Functions and methods | Blue | `#82AAFF` |
| Types, classes, and interfaces | Lavender | `#A9A0FF` |
| Strings | Green | `#9ECE8A` |
| Numbers | Yellow | `#E7BD78` |
| Constants and enum members | Peach | `#EF9F76` |
| Fields, properties, namespaces, and keys | Cyan | `#7DCFFF` |
| Annotations, decorators, and self references | Violet | `#B69CFF` |
| Operators and punctuation | Subtext | `#AAA3BF` |
| Regular expressions | Teal | `#74D3C4` |
| Errors | Red | `#F2778F` |

## Install

1. Open **Settings → Plugins**.
2. Open the gear menu and choose **Install Plugin from Disk**.
3. Select `nyx-intellij-theme.jar`.
4. Restart the IDE when prompted.
5. Choose **Nyx** under **Settings → Appearance & Behavior → Appearance**.

The UI theme selects the bundled Nyx editor scheme automatically. If the IDE
retains a project-specific scheme, choose **Nyx** under
**Settings → Editor → Color Scheme**.

The plugin is self-contained and does not require the private Nyx repository,
Settings Sync, or a network connection. This makes it suitable for a managed
work Mac directly from the public dotfiles repository.

## Verify the archive

The public bundle includes readable generated UI and editor resources under
`META-INF/` and `themes/`. To verify that the installable archive is unchanged:

```sh
cd "$HOME/dotfiles/intellij-theme/nyx"
shasum -a 256 -c SHA256SUMS
```

The canonical generator lives in the private Nyx repository. This public copy
contains only the sanitized, installable artifact and its inspectable resources.
