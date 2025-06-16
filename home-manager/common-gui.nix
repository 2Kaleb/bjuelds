{ pkgs, pkgs-unstable, ... }: {
  systemd.user.sessionVariables = { NIXOS_OZONE_WL = 1; };

  home.packages = with pkgs; [
    slurp
    grim
    wl-clipboard
    nemo
    xfce.thunar
    wlr-randr
    qimgv
    networkmanagerapplet
    baobab
    czkawka
    isd
    xorg.xeyes
    mission-center
    thunderbird
    whatsapp-for-linux
    seahorse
    gparted
  ];

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
    # thunderbird.enable=true;
    swaylock.enable = true;
    floorp.enable = true;
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
    mako.enable = true;
    kdeconnect.enable = true;
    gnome-keyring.enable = true;
  };
  services.kanshi = {
    enable = true;
    # systemdTarget = "graphical-session.target";
    settings = [{
      profile.name = "workstation";
      profile.outputs = [
        {
          criteria = "Eizo Nanao Corporation EV2456 0x03B60B34";
          # mode = "1920x1200@59.950001Hz";
          position = "0,0";
        }
        {
          criteria = "Lenovo Group Limited LEN LT2452pwC VN-669632";
          # mode = "1920x1200@59.950001Hz";
          position = "1920,0";
        }
      ];
    }];
  };

  wayland.windowManager = {
    wayfire = {
      enable = true;
      systemd.enable = true;
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
          autostart = "fish -c /etc/nixos/home-manager/autostart.fish";
        };
        core = {
          plugins =
            "alpha animate autostart command cube expo fast-switcher fisheye foreign-toplevel grid gtk-shell idle invert move oswitch preserve-output place resize scale session-lock shortcuts-inhibit simple-tile switcher vswipe vswitch wayfire-shell window-rules wm-actions wobbly wrot zoom";
          close_top_view = "<super> KEY_C";
        };
        command = {
          binding_launcher = "<super> KEY_S";
          binding_lock = "<super> <shift> KEY_X";
          binding_logout = "<super> <shift> KEY_Q";
          binding_reboot = "<super> <shift> KEY_R";
          binding_screenshot = "<super> KEY_Q";
          binding_shutdown = "<super> <shift> KEY_S";
          binding_terminal = "<super> KEY_ENTER";
          binding_filemanager = "<super> KEY_E";
          command_launcher = "fuzzel";
          command_lock = "swaylock";
          command_logout = "uwsm stop";
          command_reboot = "systemctl reboot";
          command_screenshot = ''grim -g "$(slurp -d)" - | wl-copy'';
          command_shutdown = "systemctl poweroff";
          command_terminal = "foot";
          command_filemanager = "nemo";
        };
        expo.toggle = "<super>";
        input = {
          xkb_layout = "de";
          scroll_method = "edge";
          mouse_cursor_speed = 1.0;
          touchpad_cursor_speed = 1.0;
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
        };
      };
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        gnome-keyring
      ];
      config = { common = { default = [ "wlr" "gnome-keyring" "gtk" ]; }; };
    };
  };
}
