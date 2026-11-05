{
  flake.modules.generic.home-vscode = {
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = true;
    };
  };
}
