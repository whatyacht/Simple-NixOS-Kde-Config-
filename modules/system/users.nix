{
  flake.modules.nixos.users = {
    users.users.whatyacht = {
      isNormalUser = true;
      description = "whatyacht";

      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };

    security.sudo = {
      enable = true;
      wheelNeedsPassword = true;
      execWheelOnly = true;
    };
  };
}
