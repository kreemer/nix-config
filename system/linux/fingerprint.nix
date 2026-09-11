# Fingerprint reader support for the Lenovo IdeaPad C340.
#
# The built-in reader is a Goodix GF3268 (USB 27c6:55b4). This device is NOT
# supported by upstream libfprint. Working enroll/verify is only possible with a
# community-patched fork of libfprint (jedbillyb/libfprint, branch
# goodix-55b4-fixes), pinned via the `libfprint-goodix55b4` flake input.
#
# This overlay overrides the nixpkgs `libfprint` with that fork so `fprintd`
# (and everything else) links against the patched library. The fork's `sigfm`
# matcher depends on OpenCV, which upstream nixpkgs does not wire in, so we add
# it here.
#
# CAVEATS (experimental, reverse-engineered driver):
#   * PAM is configured with fingerprint as an *additional* factor; password
#     auth remains available as a fallback so a misbehaving reader can never
#     lock you out.
#   * Matcher reliability on this small sensor depends on enrollment quality;
#     enroll with deliberately varied finger angle/pressure.
#   * After switching, enroll with `fprintd-enroll` and confirm with
#     `fprintd-verify`. `fprintd-list "$USER"` should report
#     "Goodix TLS Fingerprint Sensor 55X4".
{
  pkgs,
  lib,
  libfprint-goodix55b4,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      libfprint = prev.libfprint.overrideAttrs (old: {
        version = "1.94.6-goodix55b4";
        src = libfprint-goodix55b4;

        # The patched goodixtls55x4 driver uses the sigfm matcher, which needs
        # OpenCV (exposed as opencv4.pc by pkgs.opencv).
        buildInputs = (old.buildInputs or [ ]) ++ [ final.opencv ];

        # The fork's default drivers already include goodixtls55x4; keep the
        # nixpkgs meson flags (drivers=all also enables it in the fork).

        # Upstream install-check tests are not relevant to this fork and may
        # fail against the reverse-engineered driver.
        doInstallCheck = false;
      });
    })
  ];

  services.fprintd.enable = true;
  # Trans-Optical Driver (TOD) is for proprietary vendor drivers; the Goodix
  # support here is an in-tree driver, so TOD must stay disabled.
  services.fprintd.tod.enable = false;

  environment.systemPackages = [ pkgs.fprintd ];

  # Fingerprint as an additional auth factor; password remains a fallback.
  security.pam.services.sudo.fprintAuth = true;
  security.pam.services.login.fprintAuth = true;
  # COSMIC greeter handles both the login greeter and the lock screen.
  security.pam.services.cosmic-greeter.fprintAuth = true;
}
