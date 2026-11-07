{ ... }:

{
  flake.modules.nixos.nix = {
    nixpkgs.config = {
      allowUnfree = true;
      allowBroken = false;
    };

    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];

        download-buffer-size = 262144000;

        trusted-users = [
          "root"
          "@wheel"
        ];

        allowed-users = [
          "@wheel"
          "root"
        ];

        substituters = [
          "https://cache.nixos.org"
          "https://nix-community.cachix.org"
        ];

        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];

        extra-substituters = [
          "https://devenv.cachix.org"
        ];

        extra-trusted-public-keys = [
          "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        ];
      };
    };

    nix.optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };

    documentation = {
      doc.enable = false;
      dev.enable = false;
      info.enable = false;
      nixos.enable = false;
    };
  };
}
