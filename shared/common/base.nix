{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    eza
    bat
    jq
    yq
    azure-cli
    github-cli
    gnupg
    github-copilot-cli
    obsidian
  ];
}
