{ config, ... }:
{
  home.persistence."/persist/home/${config.home.username}" = {
    allowOther = true;
    directories = [
      "Code"
      "Documents"
      "Downloads"
      "Pictures"
      "Videos"
      ".config/cosmic"
      ".config/git"
      ".config/gh"
      ".mozilla"
      ".local/share/direnv"
      ".local/share/keyrings"
      ".gnupg"
      ".ssh"
    ];
  };
}
