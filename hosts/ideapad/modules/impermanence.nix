{ ... }:
{
  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/378699fd-81ed-4caa-b014-c6b3faae49bf";
    fsType = "btrfs";
    options = [ "subvol=persist" ];
    neededForBoot = true;
  };

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/NetworkManager"
      "/etc/NetworkManager/system-connections"
    ];

    files = [
      "/etc/machine-id"
    ];
  };
}
