{
  flake.modules.nixos.packages = { pkgs, ... }: {
    programs.nix-ld.enable = true;

    environment.systemPackages = with pkgs; [
      wget
      curl
      unzip
      zip

      impression
      gparted

      gcc
      gnumake
      pkg-config

      protonup-qt
      inotify-tools

      librewolf
      ungoogled-chromium
      qbittorrent

      jetbrains-mono

      kdePackages.kate
      kdePackages.kcalc

      prismlauncher
      vlc
    ];
  };
}
