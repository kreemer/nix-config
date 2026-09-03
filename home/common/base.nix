{ pkgs, lib, ... }:
let
  darwinSwitchSummary = pkgs.writeShellApplication {
    name = "darwin-switch-summary";
    runtimeInputs = with pkgs; [
      nix
      jq
      coreutils
      gnugrep
      gnused
    ];
    text = builtins.readFile ../../scripts/darwin-switch-summary.sh;
  };
in
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
  home.packages = [ darwinSwitchSummary ];
  home.sessionPath = [ "$HOME/.local/bin" ];
}
