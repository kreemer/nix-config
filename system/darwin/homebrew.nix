{ ... }:
{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    brews = [
      "devconhq/tap/devcon"
      "id-unibe-ch/tap/bildschirmUniversum"
    ];
    casks = [
      "balenaetcher"
      "windows-app"
    ];
  };
}
