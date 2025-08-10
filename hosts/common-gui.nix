{ pkgs, lib, ... }: {

  environment.systemPackages = with pkgs; [ brightnessctl ];
  services.blueman.enable = true;
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "kdebre";
  };
  services.seatd.enable = true;
  security.pam.services.swaylock = { };
  services.gvfs.enable = true;
  security.polkit.enable = true;
  security.soteria.enable = true;
  # services.seahorse.enable = true;
  # services.gnome-keyring.enable = true;
  services.pipewire = {
    enable = true;
    # alsa.enable = true;
    # audio.enable = true;
    wireplumber.enable = true;
  };
  services.dbus.implementation = "broker";

  networking.networkmanager.enable = true;

  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
  };

  xdg.terminal-exec = {
    enable = true;
    settings.default = [ "foot.desktop" ];
  };

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

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
        # fcitx5-chinese-addons  # table input method support
        # fcitx5-nord            # a color theme
        fcitx5-rime
        fcitx5-m17n
      ];
    };
  };

  programs.kdeconnect.enable = true;
  programs.gnome-disks.enable = true;
}
