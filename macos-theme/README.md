# Nyx macOS theme pack

A quiet native macOS layer for the Nyx palette: four dark wallpaper families,
six custom folder icons, and conservative system-setting recommendations.

The pack does not patch protected system files or replace application icons.
Everything can be applied with macOS System Settings and Finder.

## Contents

- `wallpapers/*-16x10.png` — preferred crops for most MacBook displays.
- `wallpapers/*-3x2.png` — source compositions and alternate crops.
- `folders/png/` — transparent PNG folder icons ready for Finder.
- `folders/svg/` — editable vector masters using the canonical Nyx palette.
- `settings/nyx-macos-settings.sh` — an optional, inspectable helper for the
  safe appearance settings that macOS exposes through preferences.

The wallpaper collection maps visual atmosphere to a working state:

| Wallpaper | Working state |
| --- | --- |
| Nyx Veil | neutral everyday background |
| Samurai Still | deliberate preparation and focused execution |
| Shinobi Rain | patient observation and difficult problem-solving |
| Ninja Moon | calm, sustained deep work |

The folder family is intentionally small:

| Folder | Meaning | Accent |
| --- | --- | --- |
| Developer | source code and local development | violet |
| Work | professional projects | blue |
| Forge | remote builds and infrastructure | peach |
| Nyx | Nyx sources and assets | lavender |
| Projects | general project collections | cyan |
| Archive | inactive or historical material | overlay grey |

## Recommended macOS appearance

Open **System Settings → Appearance** and use:

- Appearance: **Dark**
- Colour/accent: **Purple**
- Text highlight colour: **Nyx Violet** (`#B69CFF`), or the nearest Purple
  preset when a custom colour is unavailable
- Allow wallpaper tinting in windows: **On**
- Sidebar icon size: **Medium**
- Show scroll bars: **When scrolling**

On macOS Tahoe 26 or later, also use:

- Liquid Glass: **Tinted**
- Icon & widget style: **Dark → Always**
- Folder colour: **Automatic** while the system colour is Purple

Dark icons preserve application recognition while harmonising their surfaces.
Do not choose the fully Tinted icon style: it makes unrelated applications
monochrome and overuses violet, which the Nyx system reserves for identity and
focus.

Keep **Reduce transparency** and **Increase contrast** off initially under
**System Settings → Accessibility → Display**. Enable Reduce transparency only
if a display or wallpaper makes translucent areas difficult to read.

The optional helper applies the corresponding safe preferences and restarts
Finder and the Dock so they reload:

```sh
sh "$HOME/dotfiles/macos-theme/settings/nyx-macos-settings.sh"
```

Review the script before running it. The script does not set the wallpaper,
replace icons, or change accessibility settings. Tahoe's Liquid Glass and
icon-style choices intentionally remain documented UI steps because Apple does
not expose them through stable command-line preference keys.

## Install the wallpaper

1. Open **System Settings → Wallpaper**.
2. Choose **Add Photo** or **Add Folder**.
3. Select a `16x10` wallpaper. `nyx-samurai-still-16x10.png` is the recommended
   focused-work default; `nyx-veil-16x10.png` is the quiet everyday default.
4. Use **Fill Screen**. If the crop feels too tight on an unusual display, try
   the matching `3x2` version instead.

To rotate through the collection, choose **Add Folder** and select the
`wallpapers` directory. Do not mix the `16x10` and `3x2` variants in one
rotation on the same display; choose the crop family that fits it.

## Install a folder icon

1. Open the desired PNG under `folders/png/` in Preview.
2. Choose **Edit → Copy**.
3. Select the destination folder in Finder and choose **File → Get Info**.
4. Click the small folder icon at the top-left of the Info window.
5. Choose **Edit → Paste**.

To restore the original icon, select that same small icon in Get Info and press
Delete.

Do not replace system or application icons. They are update-prone and the
result is much less coherent than using a few meaningful project folders.

## Portability and work machines

This pack contains only public visual assets and preference documentation. It
contains no machine names, credentials, company settings, or private Nyx
repository content. On a managed work Mac, apply only settings permitted by the
organisation; the wallpaper and folder PNGs work without Settings Sync.

## Palette

The assets use the canonical Nyx colours:

```text
void       #0D0B14
crust      #12101C
mantle     #171522
base       #1D1A2B
surface0   #28243A
surface1   #37304F
surface2   #4A4167
overlay0   #665D82
overlay1   #81799C
subtext    #AAA3BF
text       #DAD6EB
violet     #B69CFF
lavender   #A9A0FF
blue       #82AAFF
cyan       #7DCFFF
peach      #EF9F76
```

Shape carries identity; accent colour carries category. Violet is reserved for
Nyx identity and focus rather than spread across every surface.
