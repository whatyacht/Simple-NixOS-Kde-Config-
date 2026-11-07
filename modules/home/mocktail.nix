{ inputs, ... }:

{
  flake.modules.generic.home-mocktail = { pkgs, ... }: {
    home.packages = [
      inputs.mocktail.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
