{ ... }:
{
  home.persistence."/persist" = {
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
