{
  description = "kreemer multi-platform nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Patched libfprint fork with support for the Goodix GF3268 (27c6:55b4)
    # fingerprint reader found in the Lenovo IdeaPad C340. Not a flake; consumed
    # as a source tree by the fingerprint overlay in system/linux/fingerprint.nix.
    # Experimental, reverse-engineered driver — see that module for caveats.
    libfprint-goodix55b4 = {
      url = "github:jedbillyb/libfprint/goodix-55b4-fixes";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      libfprint-goodix55b4,
    }:
    let
      commonModules = [ ./system/common ];

      darwinOnlyModules = [
        ./system/darwin
        ./users/kreemer-darwin.nix
      ];

      linuxOnlyModules = [
        ./system/linux
        ./users/kreemer-linux.nix
      ];

      homeCommonModules = [ ./home/common ];

      darwinHomeModules = [ ./home/darwin ];

      linuxHomeModules = [ ./home/linux ];

    in
    {
      darwinConfigurations."id-kstuder-MBP-M5-24" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit self; };
        modules =
          commonModules
          ++ darwinOnlyModules
          ++ [
            ./hosts/id-kstuder-MBP-M5-24
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.kreemer.imports = homeCommonModules ++ darwinHomeModules ++ [
                ./hosts/id-kstuder-MBP-M5-24/home.nix
              ];
            }
          ];
      };

      nixosConfigurations.ideapad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self libfprint-goodix55b4; };
        modules =
          commonModules
          ++ linuxOnlyModules
          ++ [
            ./hosts/ideapad
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.kreemer.imports = homeCommonModules ++ linuxHomeModules ++ [
                ./hosts/ideapad/home.nix
              ];
            }
          ];
      };
    };
}
