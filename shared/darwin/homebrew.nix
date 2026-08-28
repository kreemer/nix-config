{ ... }:
{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    casks = [
      "spotify"
      "balenaetcher"
    ];
  };
}
