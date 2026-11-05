{ inputs, self, ... }:

{
  flake.nixosConfigurations.whatyacht = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    specialArgs = {
      inherit inputs;
    };

    modules = [
      # Home Manager integration
      inputs.home-manager.nixosModules.home-manager

      # Hardware
      self.modules.nixos.hardware-filesystems
      self.modules.nixos.hardware-graphics

      # System
      self.modules.nixos.boot
      self.modules.nixos.nix
      self.modules.nixos.users
      self.modules.nixos.system-settings
      self.modules.nixos.packages
      self.modules.nixos.state-version
      self.modules.nixos.maintenance

      # Networking
      self.modules.nixos.networking

      # Desktop
      self.modules.nixos.plasma
      self.modules.nixos.audio

      # Services
      self.modules.nixos.system-services
      self.modules.nixos.disabled-services

      # Gaming
      self.modules.nixos.gaming

      # Home Manager configuration
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;

          extraSpecialArgs = {
            inherit inputs;
          };

          users.whatyacht.imports = [
            self.modules.generic.home-base
            self.modules.generic.home-vscode
            self.modules.generic.home-mangohud
            self.modules.generic.home-fastfetch
            self.modules.generic.home-git

            # Modules with their own imports
            self.modules.generic.home-spicetify
            self.modules.generic.home-nixcord
          ];
        };
      }
    ];
  };
}
