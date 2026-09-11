{
  pkgs,
  lib,
  config,
  self,
  ...
}:
{

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };
  nix.optimise = {
    automatic = true;
    dates = [ "03:45" ];
  };
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

  # Provide a persistent Secret Service (GNOME Keyring) and unlock it with the
  # login password. Proton pass-cli stores its encryption key here (via the
  # dbus keyring backend) so credentials survive logout/login/reboot.
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.cosmic-greeter.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # COSMIC needs the XKB rules file in the FHS path to discover layouts on NixOS.
  console.useXkbConfig = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };
  environment.sessionVariables = {
    XKB_DEFAULT_LAYOUT = "us";
    XKB_DEFAULT_VARIANT = "intl";
  };

  environment.systemPackages = with pkgs; [
    teams-for-linux
    docker
    thunderbird
    rclone
    fuse3
    fastfetch
    wl-clipboard
  ];

  # Ensure FUSE is enabled
  programs.fuse.userAllowOther = true;

  # Enable symlink for bash binary for copilot
  systemd.tmpfiles.rules = [
    "L+ /bin/bash - - - - /run/current-system/sw/bin/bash"
    "L+ /usr/share/X11/xkb/rules/base.xml - - - - ${pkgs.xkeyboard_config}/share/X11/xkb/rules/base.xml"
  ];
}
