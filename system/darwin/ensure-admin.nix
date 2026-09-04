{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.local.ensureAdmin;

  ensureAdminScript = pkgs.writeShellScript "ensure-admin" ''
    set -euo pipefail

    for user in ${lib.escapeShellArgs cfg.users}; do
      if ! /usr/sbin/dseditgroup -o checkmember -m "$user" admin >/dev/null 2>&1; then
        echo "adding $user to admin group"
        /usr/sbin/dseditgroup -o edit -a "$user" -t user admin
      fi
    done
  '';
in
{
  options.local.ensureAdmin = {
    enable = lib.mkEnableOption "restoring admin group membership via a launchd daemon";

    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Users that must stay members of the local admin group.";
    };

    interval = lib.mkOption {
      type = lib.types.ints.positive;
      default = 300;
      description = "Seconds between re-checks of the admin group membership.";
    };
  };

  config = lib.mkIf cfg.enable {
    launchd.daemons.ensure-admin = {
      # Corporate Privileges app strips admin rights on reboot, so re-add on boot and periodically.
      command = "${ensureAdminScript}";
      serviceConfig = {
        Label = "org.nixos.ensure-admin";
        RunAtLoad = true;
        StartInterval = cfg.interval;
        StandardOutPath = "/var/log/ensure-admin.log";
        StandardErrorPath = "/var/log/ensure-admin.log";
      };
    };
  };
}
