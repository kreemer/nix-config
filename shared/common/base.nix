{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    eza
    bat
    jq
    yq
    azure-cli
    github-cli
  ];
}
