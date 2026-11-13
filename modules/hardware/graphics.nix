{
  flake.modules.nixos.hardware-graphics = { pkgs, ... }: {
    services.xserver.videoDrivers = [
      "nvidia"
    ];

    hardware = {
      enableRedistributableFirmware = true;
      usbStorage.manageShutdown = true;

      bluetooth.enable = false;

      graphics = {
        enable = true;
        enable32Bit = true;
      };

      nvidia = {
        open = true;
        nvidiaSettings = true;
      };
    };
  };
}
