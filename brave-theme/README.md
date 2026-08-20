# Nyx Brave theme

A minimal Manifest V3 browser theme for Brave and other Chromium-based desktop browsers.

The theme changes browser chrome only. It does not inject CSS into websites, request permissions, execute JavaScript, or modify browser settings. Colors are mapped from the canonical Nyx palette in `stfolder/nyx`.

## Visual mapping

- frame: Nyx `crust`
- inactive frame: `void`
- active browser surface / toolbar: `base`
- inactive tabs and controls: `surface0`
- omnibox: `mantle`
- primary text: `text`
- inactive text: `subtext` / `overlay1`
- active-tab emphasis: `violet`
- toolbar icons: `lavender`
- new-tab links: `blue`

The active surface deliberately stays dark indigo instead of filling the toolbar with violet. Violet is used as a focus signal rather than ambient decoration.

## Test on Umbra

Check out the theme branch:

```bash
cd ~/dotfiles
git fetch origin
git switch agent/nyx-brave-theme 2>/dev/null \
  || git switch --track origin/agent/nyx-brave-theme

git pull --ff-only
```

Then in Brave:

1. open `brave://extensions`;
2. enable **Developer mode**;
3. choose **Load unpacked**;
4. select `~/dotfiles/brave-theme/nyx`.

The theme should apply immediately. Keep the extension page open while evaluating it so the theme can be removed or reloaded quickly.

## macOS

Use the same `brave-theme/nyx` directory from a local checkout of this repository and load it through `brave://extensions` in the same way.

This v1 theme intentionally contains no background image. Brave's own New Tab Page can be evaluated separately after the browser chrome is settled.

## Scope

This theme is intended for desktop Brave/Chromium. Mobile Brave uses the platform browser UI and does not consume this unpacked desktop theme.
