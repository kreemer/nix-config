{
  pkgs,
  lib,
  config,
  self,
  ...
}:
{
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 6;
  system.configurationRevision = self.rev or self.dirtyRev or null;
  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.systemPackages = with pkgs; [
    colima
    docker
  ];
}
