{
  flake.modules.nixos.packages = { pkgs, ... }: {
    programs = {
      nix-ld.enable = true;
      java.enable = true;

      appimage = {
        enable = true;
        binfmt = true;
      };

      obs-studio.enable = true;
    };

    environment.systemPackages = with pkgs; [
      wget
      curl
      unzip
      zip
      pciutils

      impression
      gparted

      gcc
      gnumake
      pkg-config
      openssl

      inotify-tools

      librewolf
      ungoogled-chromium
      qbittorrent
      mpv
      gimp

      kdePackages.kate
      kdePackages.kcalc
      kdePackages.kdenlive
    ];
  };
}
