{ pkgs, ... }:
{
  home.sessionVariables = {
    SSH_AUTH_SOCK = "$HOME/.ssh/proton-pass-agent.sock";
  };

  launchd.agents.proton-pass-ssh-agent = {
    enable = true;
    config = {
      ProgramArguments = [
        "/run/current-system/sw/bin/pass-cli"
        "ssh-agent"
        "start"
      ];
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/tmp/proton-pass-ssh-agent.log";
      StandardErrorPath = "/tmp/proton-pass-ssh-agent.log";
    };
  };
}
