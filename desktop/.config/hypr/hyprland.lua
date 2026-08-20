-- Nyx desktop for Hyprland 0.56+.
-- Canonical colors: https://github.com/stfolder/nyx/blob/main/themes/nyx/palette.toml

local main_mod = "SUPER"
local terminal = "kitty"
local launcher = "hyprlauncher --toggle"

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    -- Preserve native pixel density by default. Per-display overrides may
    -- opt into scaling explicitly, but automatic scaling is deliberately
    -- avoided because it made Umbra's 1080p panel unnecessarily coarse.
    scale = 1,
})

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
-- Make the desktop's dark appearance explicit in the process environment.
-- Firefox's Linux System theme does not consistently honor GTK's prefer-dark
-- flag alone, while an explicit -dark GTK theme name is reliably recognized.
hl.env("GTK_THEME", "Adwaita-dark")

hl.on("hyprland.start", function()
    -- Import the live Wayland environment before activating user services.
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE GTK_THEME && systemctl --user start hyprpolkitagent xdg-desktop-portal.service")

    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprlauncher --daemon")

    -- Cliphist stores both text and image clipboard entries. The encrypted
    -- root protects the history at rest; Super+Shift+V wipes it on demand.
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            tap_to_click = true,
            disable_while_typing = true,
            natural_scroll = true,
            clickfinger_behavior = true,
        },
    },

    general = {
        gaps_in = 6,
        gaps_out = 12,
        border_size = 2,
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",

        col = {
            active_border = { colors = { "rgba(b69cffff)", "rgba(82aaffff)" }, angle = 45 },
            inactive_border = "rgba(4a4167cc)",
        },
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 0.96,

        shadow = {
            enabled = true,
            range = 16,
            render_power = 3,
            color = "rgba(0d0b14aa)",
        },

        blur = {
            enabled = true,
            size = 8,
            passes = 2,
            vibrancy = 0.12,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        focus_on_activate = true,
    },
})

-- Short, deliberate motion: enough feedback to preserve spatial context,
-- without turning the desktop into a continuous animation.
hl.curve("nyxOut", { type = "bezier", points = { { 0.22, 1 }, { 0.36, 1 } } })
hl.curve("nyxIn", { type = "bezier", points = { { 0.64, 0 }, { 0.78, 0 } } })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 7, bezier = "nyxOut", style = "popin 96%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "nyxIn", style = "popin 96%" })
hl.animation({ leaf = "fade", enabled = true, speed = 8, bezier = "nyxOut" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "nyxOut", style = "slidefade 12%" })
hl.animation({ leaf = "layers", enabled = true, speed = 7, bezier = "nyxOut", style = "fade" })

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

-- Core shell.
hl.bind(main_mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + SPACE", hl.dsp.exec_cmd(launcher))
hl.bind(main_mod .. " + V", hl.dsp.exec_cmd("nyx-clipboard-menu"))
hl.bind(main_mod .. " + SHIFT + V", hl.dsp.exec_cmd("cliphist wipe && notify-send 'Clipboard history cleared'"))
hl.bind(main_mod .. " + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(main_mod .. " + Q", hl.dsp.window.close())
hl.bind(main_mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(main_mod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + SHIFT + E", hl.dsp.exit())

-- Focus and window movement.
for _, direction in ipairs({ "left", "right", "up", "down" }) do
    hl.bind(main_mod .. " + " .. direction, hl.dsp.focus({ direction = direction }))
    hl.bind(main_mod .. " + SHIFT + " .. direction, hl.dsp.window.move({ direction = direction }))
end

for workspace = 1, 10 do
    local key = workspace % 10
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ThinkPad media keys remain available while locked.
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Screenshots are saved and copied, so they work in chats immediately.
hl.bind("PRINT", hl.dsp.exec_cmd("nyx-screenshot full"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("nyx-screenshot area"))

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})
