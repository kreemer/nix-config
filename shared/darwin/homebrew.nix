{ ... }:
{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    brews = [
      "devconhq/tap/devcon"
    ];
    casks = [
      "spotify"
      "balenaetcher"
    ];
  };
}
