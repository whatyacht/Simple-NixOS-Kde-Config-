{
  flake.modules.generic.home-kitty = {
    programs.kitty = {
      enable = true;

      settings = {
        font_family = "JetBrainsMono Nerd Font";
        bold_font = "auto";
        italic_font = "auto";
        font_size = 10;

        # Windows 7 Command Prompt colors
        foreground = "#CCCCCC";
        background = "#000000";
        background_opacity = 1;

        cursor = "#FFFFFF";
        cursor_text_color = "#000000";

        selection_background = "#000080";
        selection_foreground = "#FFFFFF";

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
