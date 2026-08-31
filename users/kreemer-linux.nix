{ pkgs, ... }:
{
  system.primaryUser = "kreemer";

  users.users.kreemer = {
    name = "kreemer";
    home = "/home/kreemer";
    shell = pkgs.zsh;
  };
}
