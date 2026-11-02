
{ pkgs, ... }:

{
  home.username = "whatyacht";
  home.homeDirectory = "/home/whatyacht";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  # ------------------------------------------
  # VS CODE
  # ------------------------------------------

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
  };

  # ------------------------------------------
  # MANGOHUD
  # ------------------------------------------

  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
  };

  # ------------------------------------------
  # FASTFETCH
  # ------------------------------------------

  programs.fastfetch = {
    enable = true;

    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/master/doc/json_schema.json";

      logo = {
        type = "builtin";
        height = 21;
        width = 38;

        padding = {
          top = 0;
          left = 2;
        };
      };

      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "display"
        "de"
        "wm"
        "theme"
        "icons"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "break"
        "colors"
      ];
    };
  };

  # ------------------------------------------
  # GIT
  # ------------------------------------------

  programs.git = {
    enable = true;

    settings = {
      user.name = "whatyacht";
    };
  };
}
