{
  flake.modules.nixos.gaming = {
    programs.steam = {
      enable = true;

      extest.enable = true;

      remotePlay.openFirewall = true;

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
  };
}
