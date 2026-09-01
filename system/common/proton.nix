{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    proton-vpn
    proton-pass
    proton-pass-cli
    protonmail-desktop
  ];
}
