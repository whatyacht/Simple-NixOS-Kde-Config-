{
  flake.modules.nixos.system-services = {
    services = {
      dbus.enable = true;
      udisks2.enable = true;
      fwupd.enable = true;
      fstrim.enable = true;
      libinput.enable = true;
      gvfs.enable = true;

      locate = {
        enable = true;
        interval = "daily";
      };
    };

    security.polkit.enable = true;
    xdg.portal.enable = true;
  };
}
