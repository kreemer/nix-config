{
  pkgs,
  lib,
  ...
}:
{
  targets.darwin.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      # Accent color: 0=Red 1=Orange 2=Yellow 3=Green 5=Purple 6=Pink -1=Graphite
      AppleAccentColor = 3;
      "com.apple.swipescrolldirection" = false;
    };

    "com.apple.HIToolbox".AppleSelectedInputSources = [
      {
        "Bundle ID" = "com.apple.keylayout.US";
        "InputSourceKind" = "Keyboard Layout";
        "KeyboardLayout ID" = 0;
        "KeyboardLayout Name" = "U.S.";
      }
    ];
  };

  home.packages = [ pkgs.defaultbrowser ];

  home.activation.setDefaultBrowser = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD ${pkgs.defaultbrowser}/bin/defaultbrowser firefox
  '';

  # Wallpaper — uncomment and set the image path once the file is in place
  # home.activation.setWallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   $DRY_RUN_CMD osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/path/to/your/wallpaper.jpg"'
  # '';
}
