{
  flake.modules.nixos.gaming = { pkgs, ...}: {
    programs.steam = {
      enable = true;
      extest.enable = true;

      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      protontricks.enable = true;
    };

    programs.gamescope = {
      enable = true;
      capSysNice = false;
    };

    programs.gamemode = {
      enable = true;
      enableRenice = true;

      settings.general = {
        renice = 10;
        softrealtime = "auto";
      };
    };

    environment.systemPackages = with pkgs; [
      heroic
      prismlauncher

      protonup-qt
    ];
  };
}
