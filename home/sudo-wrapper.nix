{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "sudo" ''
      PRIVILEGES_CLI=/Applications/Privileges.app/Contents/MacOS/PrivilegesCLI

      if "$PRIVILEGES_CLI" --status 2>&1 | grep -q "has administrator privileges"; then
        /usr/bin/sudo -E "$@"
      else
        read -srp "Password: " PRIV_PASS
        echo

        PRIV_PASS="$PRIV_PASS" PRIVILEGES_CLI="$PRIVILEGES_CLI" /usr/bin/expect -c '
          spawn $env(PRIVILEGES_CLI) --add
          expect -re {(?i)password}
          send -- "$env(PRIV_PASS)\r"
          expect eof
        '

        echo "$PRIV_PASS" | /usr/bin/sudo -SE "$@"
      fi
    '')
  ];
}
