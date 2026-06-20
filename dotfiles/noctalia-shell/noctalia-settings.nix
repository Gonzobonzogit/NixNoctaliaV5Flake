{ ... }:

{
  programs.noctalia.settings = {
      audio = {
        enable_overdrive = true;
        enable_sounds = true;
      };
      backdrop = {
        blur_intensity = 0.0;
        enabled = true;
        tint_intensity = 0.2299999948590994;
      };
      bar = {
        order = [
          "Topside"
          "sideBar-Left"
        ];
        Topside = {
          background_opacity = 0.6399999856948853;
          border = "surface_variant";
          center = [
            "group:g2"
          ];
          end = [
            "group:g1"
            "group:g3"
            "tray"
          ];
          margin_edge = 0;
          margin_ends = 0;
          padding = 19;
          panel_overlap = 3;
          radius = 0;
          radius_bottom_left = -80;
          radius_top_left = -80;
          shadow = false;
          start = [
            "hello_2"
            "group:g5"
            "group:g4"
          ];
          thickness = 39;
          capsule_group = [
            {
              border = "primary";
              fill = "shadow";
              foreground = "tertiary";
              id = "g2";
              members = [
                "active_window"
                "workspaces"
                "cat"
              ];
              opacity = 0.44999998807907104;
              padding = 13.0;
            }
            {
              border = "primary";
              fill = "surface";
              foreground = "tertiary";
              id = "g3";
              members = [
                "ram"
                "temp"
                "sysmon"
                "network_tx"
                "network_rx"
              ];
              opacity = 0.44999998807907104;
              padding = 6.0;
            }
            {
              border = "primary";
              fill = "shadow";
              foreground = "tertiary";
              id = "g4";
              members = [
                "clock"
                "spacer1"
                "date"
              ];
              opacity = 0.44999998807907104;
              padding = 6.0;
            }
            {
              border = "primary";
              fill = "shadow";
              id = "g5";
              members = [
                "clipboard"
                "screenshot"
                "recorder_2"
              ];
              opacity = 1.0;
              padding = 9.0;
              radius = 12.0;
            }
            {
              border = "primary";
              fill = "surface";
              foreground = "tertiary";
              id = "g1";
              members = [
                "control-center"
                "spacerTop"
                "weather"
              ];
              opacity = 0.44999998807907104;
              padding = 6.0;
              radius = 30.0;
            }
          ];
        };
        sideBar-Left = {
          background_opacity = 0.64;
          border = "on_primary";
          center = [
            "group:g1"
          ];
          contact_shadow = true;
          enabled = true;
          end = [
            "group:g2"
          ];
          font_family = "0xProto Nerd Font Propo";
          margin_edge = 0;
          margin_ends = 0;
          padding = 5;
          panel_overlap = 3;
          position = "left";
          radius = 0;
          radius_bottom_left = -80;
          radius_top_right = -80;
          start = [
            "taskbar"
          ];
          thickness = 30;
          capsule_group = [
            {
              fill = "surface_variant";
              id = "g1";
              members = [
                "audio_visualizer"
                "media"
              ];
              opacity = 0.949999988079071;
              padding = 8.0;
              radius = 31.0;
            }
            {
              fill = "surface_variant";
              id = "g2";
              members = [
                "brightness"
                "volume"
                "network"
                "notifications"
                "bluetooth"
                "settings"
                "battery"
                "caffeine"
                "session"
              ];
              opacity = 1.0;
              padding = 6.0;
            }
          ];
        };
      };
      calendar = {
        enabled = true;
      };
      control_center = {
        sidebar_section = "full";
        width = 820;
      };
      desktop_widgets = {
        schema_version = 2;
        widget_order = [
          "desktop-widget-0000000000000003"
          "desktop-widget-0000000000000002"
        ];
        grid = {
          cell_size = 8;
          major_interval = 4;
          visible = true;
        };
        widget = {
          desktop-widget-0000000000000002 = {
            box_height = 80.0;
            box_width = 640.0;
            cx = 1303.0;
            cy = 872.5;
            output = "eDP-1";
            rotation = 0.0;
            type = "clock";
            settings = {
              background_color = "hover";
              background_opacity = 0.0;
              background_padding = 0.0;
              background_radius = 0.0;
              center_text = true;
              clock_style = "digital";
              color = "hover";
              font_family = "Neuropol";
              shadow = true;
            };
          };
          desktop-widget-0000000000000003 = {
            box_height = 264.0;
            box_width = 1632.0;
            cx = 767.0;
            cy = 168.5;
            flip_y = true;
            output = "eDP-1";
            rotation = 0.0;
            type = "audio_visualizer";
            settings = {
              aspect_ratio = 6.0;
              background = false;
              bands = 128.0;
              centered = false;
              mirrored = true;
              show_when_idle = true;
            };
          };
        };
      };
      dock = {
        auto_hide = true;
        background_opacity = 0.7299999836832285;
        cross_axis_padding = 11;
        enabled = true;
        icon_size = 36;
        inactive_opacity = 0.6399999856948853;
        inactive_scale = 1.0;
        launcher_icon = "snowflake";
        launcher_position = "start";
        magnification_scale = 1.3500000052154064;
        main_axis_padding = 19;
        pinned = [
          "ghostty"
          "firefox-devedition"
          "Helium"
        ];
        position = "right";
        radius = 80;
        reserve_space = false;
        show_dots = true;
      };
      hooks = {
        shutting_down = "ghostty -e cmatrix";
      };
      idle = {
        behavior_order = [
          "lock"
          "screen-off"
          "lock-and-suspend"
        ];
        behavior = {
          lock = {
            action = "lock";
            enabled = true;
            timeout = 600;
          };
          lock-and-suspend = {
            action = "lock_and_suspend";
            enabled = true;
            timeout = 900;
          };
          screen-off = {
            action = "screen_off";
            enabled = true;
            timeout = 660;
          };
        };
      };
      keybinds = {
        cancel = [
          "Escape"
        ];
        down = [
          "Down"
        ];
        left = [
          "Left"
        ];
        right = [
          "Right"
        ];
        up = [
          "Up"
        ];
        validate = [
          "Return"
        ];
      };
      location = {
        address = "Owensboro, Ky";
      };
      lockscreen = {
        allow_empty_password = true;
        blur_intensity = 0.8799999803304672;
      };
      lockscreen_widgets = {
        enabled = true;
        schema_version = 2;
        widget_order = [
          "lockscreen-widget-0000000000000004"
          "lockscreen-login-box@eDP-1"
          "lockscreen-widget-0000000000000001"
          "lockscreen-widget-0000000000000002"
          "lockscreen-widget-0000000000000003"
          "lockscreen-widget-0000000000000005"
          "lockscreen-widget-0000000000000007"
        ];
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
        widget = {
          "lockscreen-login-box@eDP-1" = {
            box_height = 64.0;
            box_width = 368.0;
            cx = 743.0;
            cy = 736.5;
            output = "eDP-1";
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_login_button = true;
            };
          };
          lockscreen-widget-0000000000000001 = {
            box_height = 288.0;
            box_width = 704.0;
            cx = 759.0;
            cy = 176.5;
            output = "eDP-1";
            rotation = 0.0;
            type = "clock";
            settings = {
              background_opacity = 0.0;
              center_text = true;
              color = "primary";
              font_family = "Pokemon Classic";
            };
          };
          lockscreen-widget-0000000000000002 = {
            box_height = 128.0;
            box_width = 512.0;
            cx = 743.0;
            cy = 832.5;
            output = "eDP-1";
            rotation = 0.0;
            type = "label";
            settings = {
              background = true;
              background_opacity = 0.31;
              background_radius = 32.0;
              color = "secondary";
              description = "If someone other than Gonzo Fuck off";
              font_family = "Quantify";
              title = "Welcome back Master Gonzo!!";
            };
          };
          lockscreen-widget-0000000000000003 = {
            box_height = 176.0;
            box_width = 384.0;
            cx = 1271.0;
            cy = 360.5;
            output = "eDP-1";
            rotation = 0.0;
            type = "weather";
            settings = {
              background = false;
            };
          };
          lockscreen-widget-0000000000000004 = {
            box_height = 416.0;
            box_width = 656.0;
            cx = 351.0;
            cy = 497.0;
            output = "eDP-1";
            rotation = 0.0;
            type = "media_player";
            settings = {
              background = true;
              background_opacity = 0.74;
              background_radius = 29.0;
              color = "tertiary";
              font_family = "0xProto Nerd Font Mono";
              hide_when_no_media = true;
              layout = "vertical";
            };
          };
          lockscreen-widget-0000000000000005 = {
            box_height = 224.0;
            box_width = 304.0;
            cx = 1175.0;
            cy = 816.5;
            output = "eDP-1";
            rotation = 0.0;
            type = "sticker";
            settings = {
              background = false;
              image_path = "/home/gonzo/Pictures/gifs/laugh-animezero2.gif";
              opacity = 1.0;
            };
          };
          lockscreen-widget-0000000000000007 = {
            box_height = 224.0;
            box_width = 304.0;
            cx = 319.0;
            cy = 817.0;
            flip_x = true;
            output = "eDP-1";
            rotation = 0.0;
            type = "sticker";
            settings = {
              background = false;
              image_path = "/home/gonzo/Pictures/gifs/laugh-animezero2.gif";
              opacity = 1.0;
            };
          };
        };
      };
      notification = {
        layer = "overlay";
      };
      osd = {
        position = "top_left";
      };
      plugins = {
        enabled = [
          "noctalia/translator"
          "noctalia/bongocat"
          "noctalia/screen_recorder"
          "noctalia/example"
        ];
      };
      shell = {
        clipboard_image_action_command = "{path}/home/gonzo/Pictures/Clipboarded";
        corner_radius_scale = 1.5000000223517418;
        font_family = "FantasqueSansM Nerd Font";
        lang = "en";
        launch_apps_as_systemd_services = true;
        niri_overview_type_to_launch_enabled = true;
        password_style = "random";
        polkit_agent = true;
        screen_time_enabled = true;
        settings_show_advanced = true;
        telemetry_enabled = true;
        panel = {
          clipboard_placement = "floating";
          launcher_compact = true;
          launcher_placement = "floating";
          launcher_session_search = true;
          open_near_click_control_center = true;
          open_near_click_launcher = true;
          transparency_mode = "glass";
        };
        screenshot = {
          directory = "~/Pictures/Screenshots";
        };
        shadow = {
          alpha = 0.8299999814480543;
          direction = "down_left";
        };
      };
      system = {
        monitor = {
          cpu_temp_activity_threshold = 81;
          cpu_temp_critical_threshold = 100;
          cpu_usage_activity_threshold = 78;
          cpu_usage_critical_threshold = 100;
          gpu_temp_activity_threshold = 75;
          gpu_temp_critical_threshold = 100;
          gpu_usage_activity_threshold = 68;
        };
      };
      theme = {
        builtin = "Catppuccin";
        mode = "dark";
        source = "wallpaper";
        wallpaper_scheme = "m3-content";
        templates = {
          builtin_ids = [
            "alacritty"
            "cava"
            "foot"
            "gtk3"
            "ghostty"
            "hyprland"
            "kitty"
            "niri"
            "qt"
            "sway"
          ];
          community_ids = [
            "zen-browser"
            "neovim"
            "obsidian"
            "discord"
            "papirus-icons"
            "telegram"
            "yazi"
            "snappy-switcher"
            "hyprtoolkit"
          ];
        };
      };
      wallpaper = {
        directory = "/home/gonzo/Pictures/NixPapers";
        edge_smoothness = 0.669999985024333;
        transition_on_startup = true;
        automation = {
          enabled = true;
        };
        default = {
          path = "/home/gonzo/Pictures/NixPapers/2bSynthWave.jpg";
        };
        last = {
          path = "/home/gonzo/Pictures/NixPapers/2bSynthWave.jpg";
        };
        monitors = {
          eDP-1 = {
            path = "/home/gonzo/Pictures/NixPapers/2bSynthWave.jpg";
          };
        };
        favorite = [
          {
            path = "/home/gonzo/Pictures/NixPapers/toykonight.png";
            theme_mode = "auto";
          }
          {
            builtin_palette = "Catppuccin";
            palette_source = "builtin";
            path = "/home/gonzo/Pictures/NixPapers/unix-chan.jpg";
            theme_mode = "dark";
          }
          {
            path = "/home/gonzo/Pictures/NixPapers/upsidedowncity.jpg";
            theme_mode = "auto";
          }
          {
            path = "/home/gonzo/Pictures/NixPapers/twinTowersVaporWave.jpg";
            theme_mode = "auto";
          }
          {
            path = "/home/gonzo/Pictures/NixPapers/vaporWaveSkyLine.jpg";
            theme_mode = "auto";
          }
        ];
      };
      weather = {
        unit = "imperial";
      };
      widget = {
        Distro_Icon = {
          color = "primary";
          glyph = "snowflake";
          icon_color = "secondary";
          scale = 1.7;
          type = "custom_button";
        };
        active_window = {
          color = "primary";
          display = "icon_only";
          font_family = "IBM Logo";
          font_weight = 400;
          icon_size = 30.0;
          max_length = 40;
          min_length = 0;
          scale = 1.1;
          title_scroll = "on_hover";
        };
        audio_visualizer = {
          bands = 106;
          color_2 = "secondary";
          show_when_idle = true;
          width = 237.0;
        };
        battery = {
          capsule = true;
          device = "/org/freedesktop/UPower/devices/battery_BAT0";
          display_mode = "graphic";
          scale = 1.2;
          show_label = false;
        };
        bluetooth = {
          scale = 1.5;
        };
        brightness = {
          scale = 1.5;
          show_label = false;
        };
        caffeine = {
          scale = 1.5;
        };
        cat = {
          audio_spectrum = true;
          rave_mode = true;
          scale = 1.85;
          tappy_mode = true;
          type = "noctalia/bongocat:cat";
          use_mpris_filter = true;
        };
        clock = {
          font_family = "Pokemon Classic";
          font_weight = 400;
          scale = 1.5;
        };
        control-center = {
          scale = 1.7;
        };
        cpu = {
          show_label = false;
          stat = "cpu_temp";
        };
        date = {
          font_family = "Pokemon Classic";
          font_weight = 400;
          scale = 1.2;
        };
        hello = {
          type = "noctalia/example:hello";
        };
        hello_2 = {
          color = "tertiary";
          glyph = "prescription";
          icon_color = "tertiary";
          label = "";
          scale = 1.9;
          type = "noctalia/example:hello";
        };
        launcher = {
          glyph = "brand-snowflake";
        };
        media = {
          art_size = 22.0;
          color = "primary";
          title_scroll = "on_hover";
        };
        network = {
          scale = 1.5;
          show_label = false;
        };
        network_rx = {
          show_label = false;
        };
        network_tx = {
          show_label = false;
        };
        notifications = {
          scale = 1.5;
        };
        privacy = {
          hide_inactive = true;
        };
        ram = {
          show_label = false;
        };
        recorder = {
          type = "noctalia/screen_recorder:recorder";
        };
        recorder_2 = {
          type = "noctalia/screen_recorder:recorder";
        };
        screenshot = {
          scale = 1.7;
        };
        session = {
          scale = 1.5;
        };
        settings = {
          scale = 1.5;
        };
        spacer1 = {
          type = "spacer";
        };
        spacerTop = {
          type = "spacer";
        };
        spacerTopleft2 = {
          type = "spacer";
        };
        spacer_2 = {
          type = "spacer";
        };
        spacer_3 = {
          type = "spacer";
        };
        sysmon = {
          show_label = false;
        };
        taskbar = {
          capsule_radius = 16;
          empty_color = "tertiary";
          group_by_workspace = true;
          group_single_icon_per_app = true;
          hide_empty_workspaces = true;
          only_active_workspace = true;
          scale = 1.25;
        };
        temp = {
          show_label = false;
        };
        tray = {
          drawer = true;
          match_adjacent_spacing = true;
          scale = 1.25;
        };
        volume = {
          scale = 1.5;
          show_label = false;
        };
        wallpaper = {
          anchor = true;
          color = "primary";
          glyph = "photo-square-rounded";
          scale = 1.3;
        };
        workspaces = {
          capsule_radius = 15;
          empty_color = "tertiary";
          focused_color = "secondary";
          labels_only_when_occupied = true;
          occupied_color = "primary";
        };
      };
    };
}
