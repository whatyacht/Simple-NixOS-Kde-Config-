{
  flake.modules.nixos.packages = { pkgs, ... }: {
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
      kitty

      kdePackages.kate
      kdePackages.kcalc

      prismlauncher
      vlc
    ];
  };
}
