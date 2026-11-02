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

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  documentation = {
    doc.enable = true;
    dev.enable = false;
    info.enable = false;
    nixos.enable = true;
  };

  # ------------------------------------------
  # BOOTLOADER & KERNEL
  # ------------------------------------------

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
        editor = false;
      };

      efi.canTouchEfiVariables = true;
      timeout = 5;
    };

    kernel.sysctl = {
      # --Kernel information protection--
      "kernel.dmesg_restrict" = 1;
      "kernel.kptr_restrict" = 2;

      # --BPF hardening--
      "net.core.bpf_jit_harden" = 2;
      "kernel.unprivileged_bpf_disabled" = 1;

      # --Process isolation--
      "kernel.yama.ptrace_scope" = 1;

      # --Kernel loading restrictions--
      "kernel.kexec_load_disabled" = 1;

      # --Disable Magic SysRq--
      "kernel.sysrq" = 0;

      # --Filesystem protections--
      "fs.protected_fifos" = 2;
      "fs.protected_regular" = 2;
      "fs.suid_dumpable" = 0;

      # --Fewer Stalls during large Writes--
      "vm.dirty_bytes" = 268435456; # 256 MB
      "vm.dirty_background_bytes" = 67108864; # 64 MB
      "vm.vfs_cache_pressure" = 50;

      # --TTY protections--
      "dev.tty.ldisc_autoload" = 0;

      # --Restrict userfaultfd--
      "vm.unprivileged_userfaultfd" = 0;

      # --Network anti-spoofing--
      "net.ipv4.conf.all.rp_filter" = 1;
      "net.ipv4.conf.default.rp_filter" = 1;

      # --SYN flood protection--
      "net.ipv4.tcp_syncookies" = 1;

      # --Disable source routing--
      "net.ipv4.conf.all.accept_source_route" = 0;
      "net.ipv4.conf.default.accept_source_route" = 0;
      "net.ipv6.conf.all.accept_source_route" = 0;
      "net.ipv6.conf.default.accept_source_route" = 0;

      # --Ignore ICMP redirects--
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.secure_redirects" = 0;
      "net.ipv4.conf.default.secure_redirects" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;

      # --Disable outgoing ICMP redirects--
      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv4.conf.default.send_redirects" = 0;

      # --ICMP protections--
      "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;

      # --TCP protection--
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
    algorithm = "zstd";
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
      nvidiaSettings = true;
    };
  };

  # ------------------------------------------
  # KDE WALLET / PAM
  # ------------------------------------------

  security.pam.services.sddm.kwallet = {
    enable = true;
    package = pkgs.kdePackages.kwallet-pam;
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

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    elisa
  ];

  programs.kde-pim.enable = false;

  # ------------------------------------------
  # AUDIO
  # ------------------------------------------

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    wireplumber.extraConfig."10-disable-libcamera" = {
      "wireplumber.profiles".main."monitor.libcamera" = "disabled";
    };

    pulse.enable = true;
    jack.enable = true;
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

      update = "sudo nix flake update --flake /etc/nixos";

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

  # --Enablements--
   services.dbus.enable = true;
   security.polkit.enable = true;
   services.udisks2.enable = true;
   services.fwupd.enable = true;
   services.fstrim.enable = true;
   services.flatpak.enable = true;

   xdg.portal.enable = true;

  # --Disablements--
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

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  programs.nh = {
    enable = true;

    clean = {
      enable = true;
      extraArgs = "--keep 5 --keep-since 7d";
    };
  };

  # ------------------------------------------
  # PACKAGES & PROGRAMS
  # ------------------------------------------

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

    settings = {
      general = {
        renice = 10;
        softrealtime = "auto";
      };
    };
  };

  programs.nano.enable = true;

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
