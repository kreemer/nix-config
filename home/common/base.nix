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
    NIX_SYSTEM_FLAKE_DIR = "$HOME/.config/nix-config";
  };

  home.stateVersion = "26.05";
  home.sessionPath = [ "$HOME/.local/bin" ];
}
