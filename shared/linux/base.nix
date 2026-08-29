{
  pkgs,
  lib,
  config,
  self,
  ...
}:
{

  nix.settings.experimental-features = "nix-command flakes";
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

  environment.systemPackages = with pkgs; [
    teams-for-linux
    docker
    thunderbird
  ];
}
