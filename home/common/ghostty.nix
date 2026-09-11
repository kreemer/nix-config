{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;

    enableZshIntegration = true;

    settings = {
      theme = "Gruvbox Dark Hard";
      font-size = "16";
      background-opacity = "0.95";
      # Work around Ghostty dead-key handling on Wayland so us(intl) keeps working.
      env = "GTK_IM_MODULE=simple";
      keybind = "global:cmd+$=toggle_quick_terminal";
      quick-terminal-position = "bottom";
      macos-titlebar-style = "tabs";
      macos-window-buttons = "hidden";
    };
  };
}
