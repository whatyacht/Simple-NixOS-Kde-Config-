{
  flake.modules.nixos.networking = {
    networking = {
      hostName = "whatyacht";

      networkmanager.enable = true;
      nftables.enable = true;

      firewall = {
        enable = true;
        allowPing = false;
      };

      nameservers = [
        "1.1.1.1#one.one.one.one"
        "1.0.0.1#one.one.one.one"
        "2606:4700:4700::1111#one.one.one.one"
        "2606:4700:4700::1001#one.one.one.one"
      ];
    };

    services.resolved = {
      enable = true;

      settings.Resolve = {
        Domains = [ "~." ];
        DNSOverTLS = "true";
        DNSSEC = "true";
      };
    };
  };
}
