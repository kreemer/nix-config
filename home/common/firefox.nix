{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.firefox = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DontCheckDefaultBrowser = true;
      DisablePocket = true;
      SearchBar = "unified";
      AIControls = {
        Default = "blocked";
      };
    };
  };
}
