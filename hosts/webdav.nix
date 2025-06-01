{ ... }: {
  # services.samba = {
  #   enable = true;
  #   openFirewall = true;
  #   settings = {
  #     global = { "map to guest" = "bad user"; };
  #     "public" = {
  #       "path" = "/Public";
  #       "read only" = "yes";
  #       "browseable" = "yes";
  #       "guest ok" = "yes";
  #       "comment" = "Public samba share.";
  #     };
  #   };
  # };
  services.webdav = {
    enable = true;
    user = "kdebre";
    settings = {
      address = "127.0.0.1";
      port = 6060;
      scope = "/srv/public";
      users = [ ];
    };
  };
  networking.firewall.allowedTCPPorts = [ 6060 ];
}
