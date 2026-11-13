{
  flake.modules.generic.home-fastfetch = {
    programs.fastfetch = {
      enable = true;

      settings = {
        logo = {
          source = "nixos_small";
          padding = {
            right = 2;
          };
        };

        display = {
          size.binaryPrefix = "si";
          color = "blue";
          separator = " 󰁔 ";
        };

        modules = [
          {
            type = "title";
            format = "{user-name}@{host-name}";
          }

          {
            type = "os";
            key = "OS";
          }

          {
            type = "host";
            key = "Host";
          }

          {
            type = "kernel";
            key = "Kernel";
          }

          {
            type = "uptime";
            key = "Uptime";
          }

          {
            type = "packages";
            key = "Packages";
          }

          {
            type = "shell";
            key = "Shell";
          }

          {
            type = "display";
            key = "Display";
          }

          {
            type = "de";
            key = "Desktop";
          }

          {
            type = "wm";
            key = "Window Manager";
          }

          "break"

          {
            type = "cpu";
            key = "CPU";
          }

          {
            type = "gpu";
            key = "GPU";
          }

          {
            type = "memory";
            key = "Memory";
          }

          {
            type = "disk";
            key = "Disk";
            folders = [ "/" ];
          }

          "break"

          {
            type = "datetime";
            key = "Date";
            format = "{1}-{3}-{11}";
          }

          {
            type = "datetime";
            key = "Time";
            format = "{14}:{17}:{20}";
          }

          "break"

          "colors"
        ];
      };
    };
  };
}
