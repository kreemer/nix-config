{ pkgs, ... }: {
  systemd.user.services.rclone-proton = {
    Unit = {
      Description = "Automount Proton Drive via Proton Pass Vault JSON";
      After = [
        "network-online.target"
        "graphical-session.target"
      ];
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      Environment = [
        "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/%U/bus"
        "XDG_RUNTIME_DIR=/run/user/%U"
      ];

      ExecStart = pkgs.writeShellScript "start-rclone-proton" ''
        sleep 2

        SECRET_DATA=$(${pkgs.proton-pass-cli}/bin/pass-cli item view \
          --vault-name Privat \
          --item-title rclone-proton-env \
          --output json | ${pkgs.jq}/bin/jq -r '.item.content.note')

        while IFS= read -r line; do
          if [[ ! -z "$line" && ! "$line" =~ ^# ]]; then
            export "$line"
          fi
        done <<< "$SECRET_DATA"

        exec ${pkgs.rclone}/bin/rclone mount protondrive: $HOME/ProtonDrive \
          --vfs-cache-mode writes \
          --log-file=$HOME/.cache/rclone/proton.log \
          --log-level=INFO
      '';

      ExecStop = "/run/current-system/sw/bin/fusermount3 -u %h/ProtonDrive";
      Restart = "on-failure";
      RestartSec = "10s";
    };
  };
}
