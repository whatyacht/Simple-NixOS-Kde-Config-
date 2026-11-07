{
  flake.modules.generic.home-kitty = {
    programs.kitty = {
      enable = true;

      settings = {
        font_family = "JetBrains Mono";
        bold_font = "auto";
        italic_font = "auto";
        font_size = 10;

        foreground = "#dcdfe4";
        background = "#1b1d23";
        background_opacity = 1;

        cursor = "#89b4fa";
        cursor_text_color = "#1b1d23";

        selection_background = "#89b4fa";
        selection_foreground = "#1b1d23";

        window_padding_width = 12;
        hide_window_decorations = false;

        scrollback_lines = 100000;

        enable_audio_bell = false;
        remember_window_size = true;
        confirm_os_window_close = 0;

        tab_bar_style = "powerline";
      };

      shellIntegration.enableFishIntegration = true;
      enableGitIntegration = true;
    };
  };
}
