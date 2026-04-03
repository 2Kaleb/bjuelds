{ pkgs, ... }:
{

  environment.pathsToLink =
    [ "/share/applications" "/share/xdg-desktop-portal" ];
  services.seatd.enable = true;
  security.pam.services.swaylock = { };
  services.gvfs.enable = true;
  security.polkit.enable = true;
  security.soteria.enable = true; # polkit agent for wayland
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
  };
  services.dbus.implementation = "broker";

  xdg.terminal-exec = {
    enable = true;
    settings.default = [ "foot.desktop" ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  programs.dconf.enable = true; # needed for GTK

  users.users.kdebre.extraGroups = [ "seat" ];
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      wayfire = {
        prettyName = "Wayfire";
        comment = "Wayfire compositor managed by UWSM";
        binPath = "/etc/profiles/per-user/kdebre/bin/wayfire";
      };
    };
  };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        rime-data
        fcitx5-gtk # alternatively, kdePackages.fcitx5-qt
        fcitx5-rime
        fcitx5-m17n
      ];
    };
  };
}
