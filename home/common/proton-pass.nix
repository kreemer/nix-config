{ pkgs, lib, ... }:
# Make Proton pass-cli use the D-Bus Secret Service (GNOME Keyring) to store its
# local encryption key instead of the Linux kernel keyring. The kernel keyring is
# wiped on logout/reboot, which otherwise loses the pass-cli session every time.
lib.mkIf pkgs.stdenv.isLinux {
  home.sessionVariables = {
    PROTON_PASS_LINUX_KEYRING = "dbus";
  };

  # systemd user services do not inherit the shell session environment, so set the
  # backend explicitly for the pass-cli SSH agent as well.
  systemd.user.services.proton-pass-agent.Service.Environment = [
    "PROTON_PASS_LINUX_KEYRING=dbus"
  ];
}
