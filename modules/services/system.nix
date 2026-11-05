{
  flake.modules.nixos.system-services = {
    services = {
      dbus.enable = true;

      udisks2.enable = true;

      fwupd.enable = true;

      fstrim.enable = true;

      flatpak.enable = true;
    };

    security.polkit.enable = true;

    xdg.portal.enable = true;
  };
}
