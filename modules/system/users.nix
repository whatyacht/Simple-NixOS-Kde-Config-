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

    security.sudo.execWheelOnly = true;
  };
}
