{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.git = {
    enable = true;
    package = pkgs.git;

    lfs.enable = true;

    ignores = [
      ".DS_Store"
      "*.swp"
      ".env"
    ];

    signing = {
      signByDefault = true;
      key = "key::ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHPGgHjY51GMbnnw9YNYZP73/X/FsF3MZn6EtNLMlLa";
    };

    settings = {
      user.name = "kreemer";
      user.email = "kevin@familie-studer.ch";

      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.config/git/allowed_signers";

      alias = {
        co = "checkout";
        ci = "commit";
        st = "status";
        br = "branch";
      };

      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  home.file.".config/git/allowed_signers".text = ''
    kevin@familie-studer.ch ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHPGgHjY51GMbnnw9YNYZP73/X/FsF3MZn6EtNLMlLa
  '';
}
