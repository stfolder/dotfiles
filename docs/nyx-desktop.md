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

## Session lifecycle

Umbra starts Hyprland deliberately from a TTY instead of using a display
manager, but the desktop still declares a real systemd graphical session.
`~/.config/systemd/user/hyprland-session.target` binds the generic
`graphical-session.target` for the lifetime of the compositor.

On `hyprland.start`, the live Wayland environment is imported into the user
systemd manager before `hyprland-session.target` is activated. Wayland-bound
services such as the polkit agent, SwayNC, and XDG Desktop Portal then start
inside a valid graphical-session lifetime. XDPH is D-Bus activated through the
portal broker instead of being launched directly.

On `hyprland.shutdown`, the Hyprland session target is stopped synchronously
before the compositor exits. Services with `PartOf=graphical-session.target`
therefore stop while the Wayland socket still exists instead of attempting to
restart against a dead compositor during the handoff back to the TTY.

SwayNC is systemd-owned. It must not also be launched directly from Hyprland,
because two owners compete for the same notification D-Bus name and force the
packaged service into `start-limit-hit`.

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
attention; blue identifies navigation. The desktop uses an illustrated Nyx
workspace built around Umbra, while the lock screen uses a dedicated guardian
composition with quiet central space for authentication. They share one visual
identity without forcing one image to do two different jobs.

## Dark appearance policy

Umbra prefers dark application chrome at the GTK layer instead of carrying a
browser-only override. GTK 3 and GTK 4 use the built-in `Adwaita` theme while
requesting dark application styling, and the Hyprland session exports
`GTK_THEME=Adwaita:dark` for applications that need the explicit variant. These
settings are part of the Stow-managed `desktop` package.

Browsers may remain on their system theme so their chrome follows the desktop
and sites that support `prefers-color-scheme` can observe a dark system color
scheme. This policy does not forcibly recolor websites that do not provide
their own dark presentation.

## Display scaling policy

Displays use their preferred mode at native `1:1` scale by default. Automatic
scaling is intentionally disabled: it selected `1.5` on Umbra's 1920x1080
panel, reducing usable space and making the image unnecessarily coarse.

This is the default for every display matched by the fallback monitor rule.
A display that genuinely needs scaling should receive an explicit per-output
override rather than changing the global fallback back to `auto`.

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

## Wallpaper paths

Hyprpaper uses
`~/dotfiles/macos-theme/wallpapers/nyx-umbra-workspace-16x9.png`.
Hyprlock uses
`~/dotfiles/macos-theme/wallpapers/nyx-umbra-guardian-16x9.png`.

The guardian image deliberately leaves the center dark for the clock, date,
password field, and user label. Both assets live in the canonical dotfiles
clone, so the complete workstation expects that repository at `~/dotfiles`.
