{
  flake.modules.generic.home-git = {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "whatyacht";
          email = "clockwork78900@outlook.com";
        };
      };
    };
  };
}
