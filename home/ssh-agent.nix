{ pkgs, ... }:
{
  services.proton-pass-agent = {
    enable = true;
    package = pkgs.proton-pass-cli;
    # Optional extra args:
    # extraArgs = [ "--refresh-interval" "7200" ];
  };
}
