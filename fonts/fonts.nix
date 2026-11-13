{
  flake.modules.nixos.fonts = { pkgs, ... }: {
    fonts.packages = with pkgs; [
      dejavu_fonts
      roboto
      liberation_ttf
      open-sans
      inter
      overpass

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      wqy_microhei
      lxgw-wenkai
      lxgw-neoxihei

      jetbrains-mono
      roboto-mono
      ibm-plex
      camingo-code
      victor-mono
      iosevka
      source-code-pro
      cascadia-code
      fira-code
      nerd-fonts.jetbrains-mono
    ];
  };
}
