{ pkgs, ... }:
{
  system.primaryUser = "kreemer";

  users.users.kreemer = {
    name = "kreemer";
    home = "/Users/kreemer";
    shell = pkgs.zsh;
  };
}
