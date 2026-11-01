{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # ------------------------------------------
  # SYSTEM
  # ------------------------------------------

  users.users.whatyacht = {
    isNormalUser = true;
    description = "whatyacht";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  # ------------------------------------------
  # NIXPKGS
  # ------------------------------------------

  nixpkgs.config.allowUnfree = true;

  # ------------------------------------------
  # BOOTLOADER & KERNEL
  # ------------------------------------------

  boot = {
    kernelPackages = pkgs.linuxPackages;
    # After rebuild, change to pkgs.linuxPackages_zen;

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 2;
        editor = false;
      };

      efi.canTouchEfiVariables = true;
      timeout = 5;
    };

    kernel.sysctl = {
      "vm.swappiness" = 10;
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };

  # ------------------------------------------
  # HARDWARE
  # ------------------------------------------

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;

    bluetooth.enable = false;

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      open = false;
      modesetting.enable = true;
      nvidiaSettings = true;
      powerManagement.enable = false;
    };
  };

  # ------------------------------------------
  # DESKTOP ENVIRONMENT
  # ------------------------------------------

  services.desktopManager.plasma6.enable = true;

  services.displayManager = {
    defaultSession = "plasma";

    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  # environment.plasma6.excludePackages = with pkgs.kdePackages; [
  #   Add Packages Here
  # ];

  # ------------------------------------------
  # AUDIO
  # ------------------------------------------

  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # ------------------------------------------
  # NETWORKING
  # ------------------------------------------

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
    hostName = "whatyacht";

    nameservers = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
      "2606:4700:4700::1111#one.one.one.one"
      "2606:4700:4700::1001#one.one.one.one"
    ];
  };

  services.resolved = {
    enable = true;

    settings.Resolve = {
      Domains = [ "~." ];

      DNSOverTLS = "true";
      DNSSEC = "true";

      FallbackDNS = [
        "1.1.1.1#one.one.one.one"
        "1.0.0.1#one.one.one.one"
        "2606:4700:4700::1111#one.one.one.one"
        "2606:4700:4700::1001#one.one.one.one"
      ];
    };
  };

  # ------------------------------------------
  # SHELL
  # ------------------------------------------

  programs.fish.enable = true;

  users.defaultUserShell = pkgs.fish;

  # ------------------------------------------
  # LOCALE / TIMEZONE
  # ------------------------------------------

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  console.keyMap = "us";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # ------------------------------------------
  # SERVICES ENABLEMENTS/DISABLEMENTS
  # ------------------------------------------

  # Enablements
   services.dbus.enable = true;
   security.polkit.enable = true;
   services.udisks2.enable = true;
   services.fwupd.enable = true;
   services.fstrim.enable = true;
   services.flatpak.enable = true;

  # Disablements
   services.orca.enable = false;
   services.avahi.enable = false;
   services.openssh.enable = false;
   services.nginx.enable = false;
   services.httpd.enable = false;
   services.postgresql.enable = false;
   services.mysql.enable = false;
   services.postfix.enable = false;
   services.samba.enable = false;
   services.vsftpd.enable = false;
   services.printing.enable = false;
   services.geoclue2.enable = false;

  # ------------------------------------------
  # AUTOMATIC OPTIMIZATIONS
  # ------------------------------------------

  systemd.services.nixos-generation-cleanup = {
    description = "Perfect Generations";

    serviceConfig.Type = "oneshot";

    path = [ pkgs.nix ];

    script = ''
      nix-env \
        --profile /nix/var/nix/profiles/system \
        --delete-generations +2

      nix-collect-garbage
    '';
  };

  systemd.timers.nixos-generation-cleanup = {
    wantedBy = [ "timers.target" ];

    timerConfig = {
      OnCalendar = "weekly";
       Persistent = true;
     };
   };

   services.fstrim.enable = true;

   nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  # ------------------------------------------
  # PACKAGES & PROGRAMS
  # ------------------------------------------

  programs.git.enable = true;
  programs.nano.enable = true;
  programs.vscode.enable = true;
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    curl
    unzip
    zip
    fastfetch
    impression
    gparted
    gcc
    gnumake
    pkg-config

    discord
    brave
    qbittorrent
    kitty
    xclicker
    kdePackages.kate
    kdePackages.kcalc
    spotify
    prismlauncher
    vlc
  ];

  system.stateVersion = "26.05";
}
