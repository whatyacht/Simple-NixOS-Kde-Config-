{
  flake.modules.nixos.plasma = { pkgs, ... }: {
    services.desktopManager.plasma6.enable = true;

    services.displayManager = {
      defaultSession = "plasma";

      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };

    security.pam.services.sddm.kwallet = {
      enable = true;
      package = pkgs.kdePackages.kwallet-pam;
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      discover
      elisa
      konsole
    ];

    programs.kde-pim.enable = false;
  };
}
