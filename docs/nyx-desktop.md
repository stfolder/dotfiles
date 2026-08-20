# Nyx desktop shell

Nyx is a coherent Wayland shell, not a themed pile of defaults. This package
maps the canonical roles in `stfolder/nyx` onto a small set of native tools and
keeps the policy visible in ordinary configuration files.

## Component contract

| Responsibility | Component | Why |
| --- | --- | --- |
| Display, input, windows, bindings | Hyprland native Lua | The compositor is the source of truth; Lua is the supported 0.56+ format |
| Applications and small pickers | hyprlauncher | Native Hyprland toolkit, instant daemon mode, and a dmenu-compatible selection path |
| Status and controls | Waybar | Mature modules for workspaces, audio, network, Bluetooth, backlight, and battery |
| Notifications | SwayNotificationCenter | Notifications plus a reviewable control center and do-not-disturb state |
| Wallpaper | hyprpaper | Small native wallpaper process with Hyprland IPC |
| Authentication and idle | hyprlock + hypridle | The lock is explicit; idle and suspend policy remain separate and inspectable |
| Clipboard | wl-clipboard + cliphist | Wayland-native text and image history with a deliberate clear operation |
| Screenshots | grim + slurp | One command for full output, one geometry selector for regions |

The former Rofi, swaylock, and Catppuccin Waybar files were removed because
they represented an older X11/wlroots setup and a different visual system.
Git history preserves them if they are ever useful as reference.

## Visual mapping

The desktop reads the same semantic palette used by Kitty, VS Code, and
IntelliJ:

- deep structure: `void`, `crust`, and `mantle`
- ordinary surfaces: `base`, `surface0`, and `surface1`
- text: silver-lavender `text` and `subtext`
- primary focus: `violet`
- navigation and active workspace: `blue`
- warnings and destructive actions: `yellow` and `red`

The bar is compact and structural. Violet is reserved for the launcher and
attention; blue identifies navigation. The lock screen uses the quiet Nyx Veil
wallpaper rather than inventing a second visual identity.

## Keyboard vocabulary

| Binding | Action |
| --- | --- |
| `Super+Return` | Open Kitty |
| `Super+Space` | Toggle application launcher |
| `Super+V` | Choose clipboard history entry |
| `Super+Shift+V` | Wipe clipboard history |
| `Super+L` | Lock session |
| `Super+Q` | Close focused window |
| `Super+F` | Toggle fullscreen |
| `Super+Shift+Space` | Toggle floating |
| `Super+1..0` | Select workspace 1..10 |
| `Super+Shift+1..0` | Move window to workspace 1..10 |
| `Print` | Save and copy a full screenshot |
| `Shift+Print` | Select, save, and copy a region |
| `Super+Shift+E` | Exit Hyprland to the console |

Three-finger horizontal touchpad gestures move between workspaces. The laptop
media keys control PipeWire, brightness, and MPRIS players even while locked.

## Idle and suspend policy

Hypridle respects D-Bus inhibitors from video players, games, and presentation
software. Without an inhibitor it:

1. locks after 10 minutes;
2. powers the display down after 11 minutes;
3. suspends after 30 minutes.

The session is also locked before any externally requested suspend. Resuming
turns the panel back on. These are policy values, not magic numbers: adjust
`~/.config/hypr/hypridle.conf` when real use shows that a different rhythm is
better.

## Clipboard privacy

Cliphist persists copied text and images under the user's home directory. On
Umbra that directory is inside the LUKS container, so history is encrypted at
rest. It is still readable by the logged-in user and their processes. Use
`Super+Shift+V` after copying a secret, or disable the two `wl-paste` watchers
in `hyprland.lua` if persistent clipboard history is undesirable.

## Wallpaper path

Hyprpaper and hyprlock use
`~/dotfiles/macos-theme/wallpapers/nyx-veil-16x10.png`. The shared asset avoids
duplicating a multi-megabyte image, but it also means the canonical clone path
for the complete workstation is `~/dotfiles`.
