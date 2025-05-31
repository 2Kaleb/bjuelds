{ pkgs, ... }: {
  systemd.user.sessionVariables = { NIXOS_OZONE_WL = 1; };

  home.packages = with pkgs; [
    slurp
    grim
    wl-clipboard
    nautilus
    wlr-randr
    qimgv
    networkmanagerapplet
    baobab
    czkawka
    isd
    xorg.xeyes
    mission-center
    thunderbird
  ];

  programs = {
    # thunderbird.enable=true;
    swaylock.enable = true;
    floorp.enable = true;
    fuzzel.enable = true;
    mpv.enable = true;
    sioyek.enable = true;
    zed-editor.enable = true;
  };

  services = {
    mako.enable = true;
    kdeconnect.enable = true;
  };

  wayland.windowManager = {
    wayfire = {
      enable = true;
      systemd.enable = true;
      wf-shell = {
        enable = true;
        settings.background = {
          image = "/etc/nixos/wallpaper";
          preserve_aspect = 0;
          cycle_timeout = 3600;
          randomize = 1;
        };
      };
      settings = {
        autostart = {
          autostart_wf_shell = false;
          wf_background = "wf-background";
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
          binding_nautilus = "<super> KEY_E";
          command_launcher = "fuzzel";
          command_lock = "swaylock";
          command_logout = "pkill -U kdebre";
          command_reboot = "systemctl reboot";
          command_screenshot = ''grim -g "$(slurp -d)" - | wl-copy'';
          command_shutdown = "systemctl poweroff";
          command_terminal = "foot";
          command_nautilus = "nautilus";
        };
        expo.toggle = "<super>";
        input = { xkb_layout = "de"; };
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
