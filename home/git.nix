{ pkgs, lib, config, ... }:
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
      key = "YOUR_GPG_KEY_ID";
    };

    settings = {
      user.name = "kreemer";
      user.email = "kevin@familie-studer.ch";

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
}
