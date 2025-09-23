{ pkgs, pkgs-unstable, ... }: {

  home.packages = with pkgs; [
    slurp
    grim
    wl-clipboard
    nemo
    kdePackages.ark
    wlr-randr
    qimgv
    networkmanagerapplet
    isd
    d-spy
    mission-center
    thunderbird
    seahorse
    catppuccin-cursors.latteDark
    piper
    wofi-emoji
    pwvucontrol
    qpwgraph
    jellyfin-media-player
    anki-bin
    swayidle
    ladybird
  ];

  wayland.windowManager = {
    wayfire = {
      enable = true;
      systemd.enable = true;
      plugins = with pkgs.wayfirePlugins; [
        wcm
        wf-shell
        wayfire-plugins-extra
      ];
      wf-shell = {
        enable = true;
        settings.background = {
          image = "/etc/nixos/home-manager/wallpaper";
          preserve_aspect = 0;
          cycle_timeout = 3600;
          randomize = 1;
        };
      };
      settings = {
        autostart = {
          autostart_wf_shell = false;
          wf_background = "wf-background";
          # portal ="systemctl start --user xdg-desktop-portal-wlr.service;systemctl start --user xdg-desktop-portal-gtk.service;";
          # polkit = "systemctl --user start polkit-soteria.service";
          # fumon = "fumon";
          # uwsm = "uwsm finalize WAYLAND_DISPLAY DISPLAY";
        };
        core = {
          plugins =
            "alpha animate autostart command cube expo fast-switcher fisheye foreign-toplevel grid gtk-shell idle invert move oswitch preserve-output place resize scale session-lock shortcuts-inhibit simple-tile switcher vswipe vswitch wayfire-shell window-rules wm-actions wobbly wrot zoom";
          close_top_view = "<super> KEY_C";
        };
        command = {
          binding_launcher = "<super> KEY_S";
          binding_sleep = "<super> <shift> KEY_X";
          binding_lock = "<super> KEY_X";
          binding_logout = "<super> <shift> KEY_Q";
          binding_reboot = "<super> <shift> KEY_R";
          binding_screenshot = "<super> KEY_Q";
          binding_shutdown = "<super> <shift> KEY_S";
          binding_terminal = "<super> KEY_ENTER";
          binding_filemanager = "<super> KEY_E";
          binding_emoji = "<super> KEY_DOT";
          command_launcher = "fuzzel";
          command_lock = "swaylock";
          command_sleep = "systemctl sleep";
          command_logout = "uwsm stop";
          command_reboot = "systemctl reboot";
          command_screenshot = ''grim -g "$(slurp -d)" - | wl-copy'';
          command_shutdown = "systemctl poweroff";
          command_terminal = "foot";
          command_filemanager = "nemo";
          command_emoji = "wofi-emoji";
        };
        expo.toggle = "<super>";
        input = {
          xkb_layout = "de";
          scroll_method = "edge";
          natural_scroll = true;
          mouse_cursor_speed = 1.0;
          touchpad_cursor_speed = 1.0;
          cursor_theme = "catppuccin-latte-dark-cursors";
          cursor_size = 48;
        };
        simple-tile.tile_by_default = "all";
        vswitch = {
          binding_1 = "<super> KEY_1";
          binding_2 = "<super> KEY_2";
          binding_3 = "<super> KEY_3";
          binding_4 = "<super> KEY_4";
          binding_5 = "<super> KEY_5";
          binding_6 = "<super> KEY_6";
          binding_7 = "<super> KEY_7";
          binding_8 = "<super> KEY_8";
          binding_9 = "<super> KEY_9";
          binding_down = "<super> KEY_J";
          binding_up = "<super> KEY_K";
          binding_left = "<super> KEY_H";
          binding_right = "<super> KEY_L";
          binding_last = "<super> KEY_TAB";
          with_win_down = "<super> <shift> KEY_J";
          with_win_up = "<super> <shift> KEY_K";
          with_win_left = "<super> <shift> KEY_H";
          with_win_right = "<super> <shift> KEY_L";
          with_win_1 = "<super> <shift> KEY_1";
          with_win_2 = "<super> <shift> KEY_2";
          with_win_3 = "<super> <shift> KEY_3";
          with_win_4 = "<super> <shift> KEY_4";
          with_win_5 = "<super> <shift> KEY_5";
          with_win_6 = "<super> <shift> KEY_6";
          with_win_7 = "<super> <shift> KEY_7";
          with_win_8 = "<super> <shift> KEY_8";
          with_win_9 = "<super> <shift> KEY_9";
        };
      };
    };
  };
  # home.file.".icons/default".source = "${pkgs.catppuccin-cursors.latteYellow}";
  # home.pointerCursor = {
  #   enable = true;
  #   package = pkgs.catppuccin-cursors.latteYellow;
  #   gtk.enable = true;
  #   name = "default";
  #   dotIcons.enable = true;
  # };

  programs.foot = let
    foot-theme = pkgs.fetchurl {
      url =
        "https://codeberg.org/dnkl/foot/raw/branch/releases/1.22/themes/kitty";
      hash = "sha256-V0m8tmR4QFRWe//ltX++ojD5X+x2x3cRHaKWfnL8OH8=";
    };
  in {
    enable = true;
    server.enable = false;
    settings = {
      main = {
        font = "JetBrainsMonoNFM-Regular:size=14";
        include = "${foot-theme}";
      };
      colors.alpha = 0.5;
    };
  };

  programs = {
    mangohud = {
      enable = true;
      settings = {
        gpu_stats = true;
        gpu_temp = true;
        cpu_stats = true;
        cpu_temp = true;
        fps = true;
        frametime = false;
        frame_timing = true;
        # Gamescope
        fsr = true;
        hide_fsr_sharpness = true;
        debug = true;
        hdr = true;
        refresh_rate = true;
        hud_no_margin = true;
        hud_compact = true;
        horizontal = true;
        toggle_hud = "Shift_R+F12";
        # toggle_hud_position=Shift_R+F11
        toggle_preset = "Shift_R+F10";
      };
    };
    # thunderbird.enable=true;
    swaylock.enable = true;
    librewolf = {
      enable = true;
      # settings = {
      #   "pdfjs.spreadModeOnLoad" = true;
      #   "browser.sessionstore.resume_from_crash" = false;
      #   "browser.bookmarks.openInTabClosesMenu" = false;
      # };
    };
    fuzzel.enable = true;
    mpv.enable = true;
    sioyek.enable = true;
    vesktop.enable = true;
    zed-editor = {
      enable = true;
      package = pkgs-unstable.zed-editor;
      # settings = { };
    };
  };

  services = {
    fnott = {
      enable = true;
      settings = { main = { default-timeout = 10; }; };
    };
    kdeconnect.enable = true;
    swayidle = {
      enable = true;
      events = [{
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
      # {
      #   event = "lock";
      #   command = "lock";
      # }
        ];
      timeouts = [
        # {
        #   timeout = 300;
        #   command = "${pkgs.swaylock}/bin/swaylock -fF";
        # }
        {
          timeout = 1800;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };
    shikane = {
      enable = true;
      settings = {
        profile = [
          {
            name = "workstation";
            output = [
              {
                enable = true;
                search = [
                  "n=HDMI-A-2"
                  "m=EV2456"
                ]; # , v=Eizo Nanao Corporation, s=0x03B60B34";
                position = "0,0";
              }
              {
                enable = true;
                search = [
                  "n=HDMI-A-1"
                  "m=LEN LT2452pwC"
                ]; # , v=Lenovo Group Limited,  s=VN-669632";
                position = "1920,0";
              }
            ];
          }
          {
            name = "laptop";
            output = [
              {
                enable = true;
                search = "n=eDP-1";
                position = "0,0";
              }
              {
                enable = true;
                search = [ "n=HDMI-A-1" ];
                position = "900,-1080";
              }
            ];
          }
          {
            name = "asrock-b850i";
            output = [
              {
                enable = true;
                search = [ "m=XF240YU" ];
                mode = "2560x1440@143.856003Hz";
                position = "0,0";
                adaptive_sync = true;
              }
              {
                enable = true;
                search = [ "n=HDMI-A-2" ];
                position = "2560,0";
              }
            ];
          }
        ];
      };
    };
  };
  gtk = {
    enable = true;
    # colorScheme = null;
    iconTheme = null;
    theme = null;
    cursorTheme = {
      name = "catppuccin-latte-dark-cursors";
      size = 48;
    };
  };
  xdg = {
    desktopEntries = {
      "dev.zed.Zed" = {
        name = "Zed";
        exec = "mangohud zeditor %U";
        icon = "zed";
        mimeType = [ "text/plain" ];
      };
    };
    portal = {
      enable = true;
      # xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        # gnome-keyring
        darkman
      ];
      # config = { common = { default = [ "wlr" "gnome-keyring" "gtk" ]; }; };
      config = {
        wlroots = {
          default = [ "gtk" ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
          "org.freedesktop.impl.portal.Settings" = [ "darkman" ];
        };
      };
    };
  };
}
