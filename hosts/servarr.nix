{ config, lib, pkgs, ... }:

{
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = { "map to guest" = "bad user"; };
      "public" = {
        "path" = "/mnt/public";
        "read only" = "yes";
        "browseable" = "yes";
        "guest ok" = "yes";
        "comment" = "Public samba share.";
      };
    };
  };

  services = {
    sonarr = {
      enable = true;
      openFirewall = true;
      user = "kdebre";
      group = "users";
    };
    bazarr = {
      enable = true;
      openFirewall = true;
      user = "kdebre";
      group = "users";
    };
    lidarr = {
      enable = true;
      openFirewall = true;
      user = "kdebre";
      group = "users";
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    radarr = {
      enable = true;
      openFirewall = true;
      user = "kdebre";
      group = "users";
    };
    readarr = {
      enable = true;
      openFirewall = true;
      user = "kdebre";
      group = "users";
    };
    jellyfin = {
      enable = true;
      openFirewall = true;
      user = "kdebre";
      group = "users";
    };
    jellyseerr = {
      enable = true;
      openFirewall = true;
    };
    sabnzbd = {
      enable = true;
      openFirewall = true;
      user = "kdebre";
      group = "users";
    };
  };
}
