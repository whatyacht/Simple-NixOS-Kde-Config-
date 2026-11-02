{ config, pkgs, lib, ... }:

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

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };

  # ------------------------------------------
  # NIX CONFIGURATION
  # ------------------------------------------

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      download-buffer-size = 262144000;

      allowed-users = [ "@wheel" ];

      extra-substituters = [
        "https://nix-community.cachix.org"
      ];

      # Nix Community cache signing key
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  documentation = {
    doc.enable = false;
    dev.enable = false;
    info.enable = false;
    nixos.enable = false;
  };

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
      # Kernel information protection
      "kernel.dmesg_restrict" = 1;
      "kernel.kptr_restrict" = 2;

      # BPF hardening
      "net.core.bpf_jit_harden" = 2;
      "kernel.unprivileged_bpf_disabled" = 1;

      # Process isolation
      "kernel.yama.ptrace_scope" = 1;

      # Kernel loading restrictions
      "kernel.kexec_load_disabled" = 1;

      # Disable Magic SysRq
      "kernel.sysrq" = 0;

      # Restrict performance monitoring
      "kernel.perf_event_paranoid" = 3;

      # Filesystem protections
      "fs.protected_fifos" = 2;
      "fs.protected_regular" = 2;
      "fs.suid_dumpable" = 0;

      # TTY protections
      "dev.tty.ldisc_autoload" = 0;

      # Restrict userfaultfd
      "vm.unprivileged_userfaultfd" = 0;

      # Network anti-spoofing
      "net.ipv4.conf.all.rp_filter" = 1;
      "net.ipv4.conf.default.rp_filter" = 1;

      # SYN flood protection
      "net.ipv4.tcp_syncookies" = 1;

      # Disable source routing
      "net.ipv4.conf.all.accept_source_route" = 0;
      "net.ipv4.conf.default.accept_source_route" = 0;
      "net.ipv6.conf.all.accept_source_route" = 0;
      "net.ipv6.conf.default.accept_source_route" = 0;

      # Ignore ICMP redirects
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.secure_redirects" = 0;
      "net.ipv4.conf.default.secure_redirects" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;

      # Disable outgoing ICMP redirects
      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv4.conf.default.send_redirects" = 0;

      # ICMP protections
      "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;

      # TCP protection
      "net.ipv4.tcp_rfc1337" = 1;
    };

    kernelParams = [
      "init_on_alloc=1"
      "init_on_free=1"
      "slab_nomerge"
      "page_alloc.shuffle=1"
      "randomize_kstack_offset=1"
    ];

    blacklistedKernelModules = [
      "dccp"
      "sctp"
      "rds"
      "tipc"
      "firewire-core"
      "firewire-ohci"
      "firewire-sbp2"
    ];
  };

  security.sudo.execWheelOnly = true;

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
      open = true;
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

    nftables.enable = true;

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
    };
  };

  # ------------------------------------------
  # SHELL
  # ------------------------------------------

  programs.fish = {
    enable = true;

    shellAliases = {
      rebuild = "nh os switch /etc/nixos";
      build = "nh os build /etc/nixos";
      trybuild = "nh os test /etc/nixos";
      update = "nix flake update --flake /etc/nixos";
      clean = "nh clean all";
    };
  };

  users.defaultUserShell = pkgs.fish;

  # ------------------------------------------
  # LOCALE / TIMEZONE
  # ------------------------------------------

  time.timeZone = lib.mkDefault "America/New_York";

  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";

    extraLocaleSettings = lib.mapAttrs (_: lib.mkDefault) {
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
  };

  services.xserver.xkb = {
    layout = lib.mkDefault "us";
    variant = "";
  };

  console.keyMap = lib.mkDefault "us";

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

   xdg.portal.enable = true;

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
    description = "NixOS Generation Cleanup";

    serviceConfig = {
      Type = "oneshot";
    };

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

  nix.settings.auto-optimise-store = true;

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  # ------------------------------------------
  # PACKAGES & PROGRAMS
  # ------------------------------------------

  programs.nh = {
    enable = true;
    clean.enable = false;
  };

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

  programs.nano.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    curl
    unzip
    zip
    impression
    gparted
    gcc
    gnumake
    pkg-config
    protonup-qt
    inotify-tools

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
