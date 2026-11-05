{
  flake.modules.nixos.disabled-services = {
    services = {
      orca.enable = false;
      avahi.enable = false;
      openssh.enable = false;
      nginx.enable = false;
      httpd.enable = false;
      postgresql.enable = false;
      mysql.enable = false;
      postfix.enable = false;
      samba.enable = false;
      vsftpd.enable = false;
      printing.enable = false;
      geoclue2.enable = false;
    };
  };
}
