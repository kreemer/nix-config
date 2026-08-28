{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autocd = true;

    shellAliases = {
      ll = "eza -la --icons";
      ls = "eza";
      cat = "bat";
      gs = "git status";
      gc = "git commit";
      gp = "git push";
    };
    
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
    
    plugins = [];
  };
}
