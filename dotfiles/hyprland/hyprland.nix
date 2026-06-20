{ config, pkgs, ... }:

{
  # Hyprland 0.55+ Lua config, written declaratively via home-manager.
  #
  # Note: home-manager's wayland.windowManager.hyprland.settings still
  # generates hyprlang (hyprland.conf), not Lua, so we drop the Lua file
  # directly via xdg.configFile and let Hyprland pick it up.
  #
  # The NixOS module (programs.hyprland.enable = true) should still be set
  # in your system configuration.nix for session files, portals, polkit, etc.

  xdg.configFile."hypr/hyprland.lua".text = ''
    --------------------------------------------------------------------------------
    --                          Hyprland Lua config
    --------------------------------------------------------------------------------

    --------------------
    ---   Display    ---
    ---   Monitors   ---
    --------------------
--hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@100", position = "0x0",    scale = 1 })
--hl.monitor({ output = "DP-3", mode = "1280x1024@75", position = "1920x0", scale = 1 })
    --Laptop Screen Config below--
    hl.monitor({ output = "eDP-1", mode = "1920x1200@60", position = "0x0", scale = 1.50})


    ------------------------
    --- Application Vars ---
    ------------------------
    -- Declared early so autostart and binds can reference them.
	local oldTerm   = "cool-retro-term"
    local terminal       = "ghostty"
    local fileManager    = "nautilus"
    local browser        = "firefox-devedition"
    local wolf           = "librewolf"
    local email          = "thunderbird"
    local chat           = "equibop"
    local doom           = "emacs"
    local music          = "spotify"
    local tuiManager     = "ghostty -e yazi"
    local msty	         = "msty"
    local helium         ="helium"

    --------------------------
    --- Noctalia Variables ---
    --------------------------

    local launcher              = "qs -c noctalia-shell ipc call launcher toggle"
    local settingsPanel         = "qs -c noctalia-shell ipc call settings toggle"
    local controlCenter         = "qs -c noctalia-shell ipc call controlCenter toggle"
    local windowSwitcher        = "qs -c noctalia-shell ipc call launcher windows"
    local lock                  = "qs -c noctalia-shell ipc call lockScreen lock"
    local sessionPanel          = "qs -c noctalia-shell ipc call sessionMenu toggle"
    local emoji                 = "qs -c noctalia-shell ipc call launcher emoji"
    local wallpaperPanel        = "qs -c noctalia-shell ipc call wallpaper toggle"
    local liveWallpapers        = "qs -c noctalia-shell ipc call wallpaper toggleLive"
    local wallcard              = "qs -c noctalia-shell ipc call plugin:wallcards toggle"
    local dock                  = "qs -c noctalia-shell ipc call dock show"
    local movieMode             = "qs -c noctalia-shell ipc call idleInhibitor toggle"
    local screenKit             = "qs -c noctalia-shell ipc call plugin:screen-toolkit toggle"
    local record                = "qs -c noctalia-shell ipc call plugin:screen-recorder toggle"
    local keybind               = "qs -c noctalia-shell ipc call plugin:keybind-cheatsheet toggle"
    local defaultAppPicker      = "qs -c noctalia-shell ipc call plugin:mimeapp-gui openPanel"
    local HVE                   = "qs -c noctalia-shell ipc call plugin:hyprland-visual-editor toggle"
    local picker                = "qs -c noctalia-shell ipc call plugin:screen-toolkit colorPicker"
    local screen      			= "qs -c noctalia-shell ipc call plugin:screen-shot-and-record screenshot"


    ------------------
    --- AutoStart  ---
    ------------------

    hl.on("hyprland.start", function ()
      hl.exec_cmd(terminal)
      hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
      hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
      hl.exec_cmd("protonmail-bridge")
      hl.exec_cmd("nm-applet")
      hl.exec_cmd("qs -c noctalia-shell")
      hl.exec_cmd("mullvad connect")
    end)


    ---------------------
    ---  Environment  ---
    ---------------------

    hl.env("XCURSOR_SIZE",         "24")
    hl.env("HYPRCURSOR_SIZE",      "24")
    hl.env("GTK_THEME",            "Dracula")
    hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")


    -----------------------
    ---   Permissions   ---
    -----------------------

    hl.config({
      ecosystem = {
        enforce_permissions = false,
      },
    })

    -- NixOS store paths are content-addressed, so the hash changes on every
    -- rebuild. The regex form is the right approach here.
    hl.permission("/nix/store/[a-z0-9]{32}-grim-[0-9.]*/bin/grim", "screencopy", "allow")
    hl.permission("/nix/store/[a-z0-9]{32}-xdg-desktop-portal-hyprland-[0-9.]*/libexec/.xdg-desktop-portal-hyprland-wrapped", "screencopy", "allow")
    hl.permission("/nix/store/[a-z0-9]{32}-hyprland-[0-9.]*/bin/hyprpm", "plugin", "allow")
    hl.permission("/nix/store/[a-z0-9]{32}-grim-[0-9.]*/bin/grim",                  "screencopy", "allow")
    hl.permission("/nix/store/[a-z0-9]{32}-slurp-[0-9.]*/bin/slurp",                "screencopy", "allow")
    hl.permission("/nix/store/[a-z0-9]{32}-wf-recorder-[0-9.]*/bin/wf-recorder",    "screencopy", "allow")
    hl.permission("/nix/store/[a-z0-9]{32}-quickshell-[0-9.]*/bin/qs",              "screencopy", "allow")

    --------------
    --- Layout ---
    --------------

--    hl.config({
--      dwindle = {
--        force_split                  = 0,
--        preserve_split               = true,
--        smart_split                  = true,
---        smart_resizing               = true,
--        permanent_direction_override = false,
--        special_scale_factor         = 1,
 --       split_width_multiplier       = 1.0,
 --       use_active_for_splits        = true,
--        default_split_ratio          = 1.0,
--        split_bias                   = 10,
--        precise_mouse_move           = true,
--      },
--    })

    hl.config({
      scrolling = {
        column_width             = 0.5,
        follow_focus             = true,
        wrap_focus               = false,
        follow_min_visible       = 0.3,
        wrap_swapcol             = true,
        focus_fit_method         = 1,
        direction                = "right",
        fullscreen_on_one_column = true,
      },
    })
       
   


    ---------------------
    --- Look and Feel ---
    ---------------------

    hl.config({
      general = {
        gaps_in     = 5,
        gaps_out    = 20,
        border_size = 2,

        col = {
          active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
          inactive_border = "rgba(595959aa)",
        },

        resize_on_border = true,
        allow_tearing    = true,
        layout           = "scrolling",
      },

      decoration = {
        rounding         = 10,
        rounding_power   = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
          enabled      = true,
          range        = 4,
          render_power = 3,
          color        = "rgba(1a1a1aee)",
        },

        blur = {
          enabled  = true,
          size     = 3,
          passes   = 2,
          vibrancy = 0.1696,
        },
      },

      animations = {
        enabled = true,
      },
    })


    -------------------
    --- Animations  ---
    -------------------

    hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
    hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
    hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}    } })
    hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
    hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}  } })

    -- Default spring
    hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

    hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
    hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
    hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, spring = "easy" })
    hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  spring = "easy",         style = "popin 87%" })
    hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
    hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
    hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
    hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
    hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
    hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
    hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
    hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
    hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
    hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
    hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
    hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
    hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })


    ----------------
    ----  MISC  ----
    ----------------

    hl.config({
      misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
      },
    })


    ---------------
    --- Inputs ----
    ---------------

    hl.config({
      input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
          natural_scroll = false,
        },
      },
    })

    hl.gesture({
      fingers   = 3,
      direction = "horizontal",
      action    = "workspace",
    })


    ------------------
    --- Workspaces ---
    ------------------
    hl.workspace_rule({ workspace = "1",  monitor = "eDP-1", default = true })
    hl.workspace_rule({ workspace = "2",  monitor = "eDP-1", default = true })
    hl.workspace_rule({ workspace = "3",  monitor = "eDP-1", default = true })
    hl.workspace_rule({ workspace = "4",  monitor = "eDP-1", default = true })
    hl.workspace_rule({ workspace = "5",  monitor = "eDP-1", default = true })
    hl.workspace_rule({ workspace = "6",  monitor = "eDP-1", default = true })
    hl.workspace_rule({ workspace = "7",  monitor = "eDP-1", default = true })
    hl.workspace_rule({ workspace = "8",  monitor = "eDP-1", default = true })
    hl.workspace_rule({ workspace = "9",  monitor = "eDP-1", default = true })
    hl.workspace_rule({ workspace = "10",  monitor = "eDP-1", default = true })


    -------------
    --- Binds ---
    -------------

    local mainMod = "SUPER"

    --- App launchers ---
    hl.bind(mainMod .. " + SHIFT + Return",               hl.dsp.exec_cmd(oldTerm))
    hl.bind(mainMod .. " + Return",                       hl.dsp.exec_cmd(terminal))
    hl.bind(mainMod .. " + E",                            hl.dsp.exec_cmd(chat))
    hl.bind(mainMod .. " + B",                            hl.dsp.exec_cmd(browser))
    hl.bind(mainMod .. " + SHIFT + B",                    hl.dsp.exec_cmd(helium))
    hl.bind(mainMod .. " + ALT + B",                      hl.dsp.exec_cmd(wolf))
    hl.bind(mainMod .. " + D",                            hl.dsp.exec_cmd(doom))
    hl.bind(mainMod .. " + Y",                            hl.dsp.exec_cmd(tuiManager))
    hl.bind(mainMod .. " + S",                            hl.dsp.exec_cmd(music))
    hl.bind(mainMod .. "+ CTRL + C",                      hl.dsp.exec_cmd(picker))
    hl.bind(mainMod .. " + T",                            hl.dsp.exec_cmd(email))
    hl.bind(mainMod .. " + Q",                            hl.dsp.window.close())
    hl.bind(mainMod .. " + L",                            hl.dsp.exec_cmd(msty))

    --- Noctalia control ---
    hl.bind("PRINT",							          hl.dsp.exec_cmd(screen))
    hl.bind(mainMod .. " + TAB",                          hl.dsp.exec_cmd(windowSwitcher))
    hl.bind(mainMod .. " + HOME",                         hl.dsp.exec_cmd(settingsPanel))
    hl.bind(mainMod .. " + CTRL + HOME",                  hl.dsp.exec_cmd(controlCenter))
    hl.bind(mainMod .. " + M",                            hl.dsp.exec_cmd(launcher))
    hl.bind(mainMod .. " + INSERT",                       hl.dsp.exec_cmd(wallpaperPanel))
    hl.bind(mainMod .. " + INSERT + SPACE",               hl.dsp.exec_cmd(liveWallpapers))
    hl.bind(mainMod .. " + CTRL + L", 			          hl.dsp.exec_cmd(lock))
    hl.bind(mainMod .. " + CTRL + I",                     hl.dsp.exec_cmd(movieMode))
    hl.bind(mainMod .. " + CTRL + SHIFT + HOME",          hl.dsp.exec_cmd(screenKit))
    hl.bind(mainMod .. " + CTRL + R",                     hl.dsp.exec_cmd(record))
    hl.bind(mainMod .. " + F1",                           hl.dsp.exec_cmd(keybind))
    hl.bind(mainMod .. " + F12",                          hl.dsp.exec_cmd(defaultAppPicker))
    hl.bind(mainMod .. " + F11",                          hl.dsp.exec_cmd(HVE))

    --- ScrollingLayout ---
    hl.bind(mainMod .. " + CTRL + T",                     hl.dsp.layout("inhibit_scroll bool"))
    hl.bind(mainMod .. " + V",                            hl.dsp.layout("fit expand")) 
    hl.bind(mainMod .. " + Z",                            hl.dsp.layout("promote"))
    hl.bind(mainMod .. " +SHIFT+EQUAL",                   hl.dsp.layout("colresize +0.1"))
    hl.bind(mainMod .. "+ SHIFT + PERIOD",                hl.dsp.layout("expel"))
    hl.bind(mainMod .. "+ SHIFT + COMMA",                 hl.dsp.layout("consume"))
    hl.bind(mainMod .. "+ CTRL + SHIFT + SPACE",          hl.dsp.layout("consume_or_expel"))
    hl.bind(mainMod .. " +SHIFT+MINUS",                   hl.dsp.layout("colresize -0.1"))

    --- Tile in scrolling aka consume/expel ---
    --- Move window with SHIFT + arrows ---
    hl.bind(mainMod .. " + SHIFT + page_up",              hl.dsp.focus({ workspace = "+1" })) 
    hl.bind(mainMod .. " + SHIFT + page_down",            hl.dsp.focus({ workspace = "-1" })) 
    hl.bind(mainMod .. " + SHIFT + right",				        hl.dsp.layout("swapcol r"))
    hl.bind(mainMod .. " + SHIFT + left",                 hl.dsp.layout("swapcol l"))
    hl.bind(mainMod .. " + SHIFT + right",                hl.dsp.layout("swapcol r"))





    --- Window state ---
    hl.bind(mainMod .. " + CTRL + F3", hl.dsp.window.float({ action = "toggle" }))
    hl.bind(mainMod .. " + F4",        hl.dsp.window.fullscreen({ action = "toggle", fullscreen_state_client = 1 }))
    hl.bind(mainMod .. " + CTRL + F4", hl.dsp.window.fullscreen({ action = "toggle", fullscreen_state_client = 0 }))
    

    --- Move Window to adjacent workspace ---
    --hl.bind(mainMod .. "+ CTRL + ALT + right", hl.dsp.( workspace = "+1"))
    --hl.bind(mainMod .. "+ CTRL + ALT + left", hl.dsp.window.move(workspace = "-1"))

    --- Focus movement ---
    hl.bind(mainMod .. " + left",         hl.dsp.focus({ direction = "left" }))
    hl.bind(mainMod .. " + right",        hl.dsp.focus({ direction = "right" }))
    hl.bind(mainMod .. " + up",           hl.dsp.focus({ direction = "up" }))
    hl.bind(mainMod .. " + down",         hl.dsp.focus({ direction = "down" }))

    --- Workspace nav with arrows / scroll ---
    hl.bind(mainMod .. " + mouse_down",         hl.dsp.focus({ workspace = "e+1" }))
    hl.bind(mainMod .. " + mouse_up",           hl.dsp.focus({ workspace = "e-1" }))


    --- Special workspaces: move window TO ---
    hl.bind(mainMod .. " + CTRL + SHIFT + 1", hl.dsp.window.move({ workspace = "special:Steam" }))
    hl.bind(mainMod .. " + CTRL + SHIFT + E", hl.dsp.window.move({ workspace = "special:discord" }))
    hl.bind(mainMod .. " + CTRL + SHIFT + 2", hl.dsp.window.move({ workspace = "special:system-monitor" }))
    hl.bind(mainMod .. " + CTRL + SHIFT + S", hl.dsp.window.move({ workspace = "special:music" }))
    hl.bind(mainMod .. " + CTRL + SHIFT + 4", hl.dsp.window.move({ workspace = "special:server" }))
    hl.bind(mainMod .. " + CTRL + SHIFT + T", hl.dsp.window.move({ workspace = "special:mail" }))
    hl.bind(mainMod .. " + CTRL + SHIFT + N", hl.dsp.window.move({ workspace = "special:hide-notes" }))

    --- Special workspaces: toggle visibility ---
    hl.bind("ALT + CTRL + SHIFT + 1", hl.dsp.workspace.toggle_special("Steam"))
    hl.bind("ALT + CTRL + SHIFT + E", hl.dsp.workspace.toggle_special("discord"))
    hl.bind("ALT + CTRL + SHIFT + 2", hl.dsp.workspace.toggle_special("system-monitor"))
    hl.bind("ALT + CTRL + SHIFT + S", hl.dsp.workspace.toggle_special("music"))
    hl.bind("ALT + CTRL + SHIFT + 4", hl.dsp.workspace.toggle_special("server"))
    hl.bind("ALT + CTRL + SHIFT + T", hl.dsp.workspace.toggle_special("mail"))
    hl.bind("ALT + CTRL + SHIFT + N", hl.dsp.workspace.toggle_special("hide-notes"))

    --- Mouse bindings ---
    hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
    hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

    --- Multimedia keys (with repeat + lockscreen pass-through) ---
    hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),    { locked = true, repeating = true })
    hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),         { locked = true, repeating = true })
    hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),        { locked = true })
    hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),      { locked = true })
    hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                    { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                    { locked = true, repeating = true })

    --- Media keys (locked-screen pass-through) ---
    hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
    hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


    -- This loads Noctalia-generated Hyprland colors.
    dofile("/home/gonzo/.config/hypr/noctalia/noctalia-colors.lua")
--    dofile("/home/gonzo/.cache/noctalia/HVE/overlay.conf")
  '';
}
