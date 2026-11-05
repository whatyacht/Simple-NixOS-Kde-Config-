{ inputs, ... }:

{
  flake.modules.generic.home-spicetify = { pkgs, ... }: {
    imports = [
      inputs.spicetify-nix.homeManagerModules.default
    ];

    programs.spicetify = {
      enable = true;

      enabledExtensions =
        with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.extensions; [
          adblock
          hidePodcasts
          shuffle
        ];

      enabledCustomApps =
        with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.apps; [
          newReleases
          ncsVisualizer
        ];

      enabledSnippets =
        with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.snippets; [
          rotatingCoverart
          pointer
        ];

      theme = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.themes.catppuccin;

      colorScheme = "mocha";
    };
  };
}
