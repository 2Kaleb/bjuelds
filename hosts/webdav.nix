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
    user = "root";
    settings = {
      address = "0.0.0.0";
      port = 80;
      scope = "/srv/public";
      users = [ ];
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
