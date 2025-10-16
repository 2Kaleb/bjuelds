{ ... }: {
  # users.groups.copyparty = { };
  services.copyparty = {
    enable = true;
    user = "kdebre";
    settings = {
      i = "127.0.0.1";
      p = [ 3923 ];
      xff-hdr = "x-forwarded-for";
      xff-src = "127.0.0.1";
      rproxy = 1;
      allow-csrf = true;
      daw = true;
    };
    accounts = { kdebre.passwordFile = "/home/kdebre/.secret-copyparty"; };
    volumes = {
      "/" = {
        path = "/srv/public";
        access = { rwmd = [ "kdebre" ]; };
      };
    };
  };
}
