{ pkgs, lib, ... }:
{
  programs = {
    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    fzf.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "hx";
    TERMINAL = "ghostty";
  };

  home.stateVersion = "26.05";
  home.sessionPath = [ "$HOME/.local/bin" ];
}
