{
  flake.modules.nixos.system-settings = { pkgs, lib, ... }: {
    time.timeZone = lib.mkDefault "America/New_York";

    i18n = {
      defaultLocale = lib.mkDefault "en_US.UTF-8";

      extraLocaleSettings = lib.mapAttrs (_: lib.mkDefault) {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };
    };

    services.xserver.xkb = {
      layout = lib.mkDefault "us";
      variant = "";
    };

    console.keyMap = lib.mkDefault "us";

    programs.fish = {
      enable = true;

      shellAliases = {
        rebuild = "nh os switch /etc/nixos";
        build = "nh os build /etc/nixos";
        trybuild = "nh os test /etc/nixos";
        update = "sudo nix flake update --flake /etc/nixos";
        clean = "nh clean all";
      };
    };

    programs.nano.enable = true;

    users.defaultUserShell = pkgs.fish;
  };
}
