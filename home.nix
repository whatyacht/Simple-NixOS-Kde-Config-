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
  # GIT
  # ------------------------------------------

  programs.git = {
    enable = true;

    settings = {
      user.name = "whatyacht";
    };
  };
}
