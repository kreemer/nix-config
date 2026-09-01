{
  description = "kreemer multi-platform nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
    }:
    let
      commonModules = [
        ./shared/common/base.nix
        ./shared/common/proton.nix
        ./shared/common/shell.nix
      ];

      darwinOnlyModules = [
        ./shared/darwin/base.nix
        ./shared/darwin/homebrew.nix
        ./users/kreemer-darwin.nix
      ];

      linuxOnlyModules = [
        ./shared/linux/base.nix
        ./users/kreemer-linux.nix
      ];

      homeCommonModules = [
        ./home/base.nix
        ./home/ghostty.nix
        ./home/git.nix
        ./home/helix.nix
        ./home/ssh-agent.nix
        ./home/zsh.nix
        ./home/firefox.nix
        # ./home/protondrive.nix
      ];

      darwinHomeModules = [
        ./home/darwin-settings.nix
      ];

    in
    {
      darwinConfigurations."id-kstuder-MBP-M5-24" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit self; };
        modules =
          commonModules
          ++ darwinOnlyModules
          ++ [
            ./hosts/id-kstuder-MBP-M5-24.darwin.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.kreemer.imports = homeCommonModules ++ darwinHomeModules ++ [
                ./hosts/id-kstuder-MBP-M5-24.hm.nix
              ];
            }
          ];
      };

      nixosConfigurations.ideapad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          commonModules
          ++ linuxOnlyModules
          ++ [
            ./hosts/ideapad.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.kreemer.imports = homeCommonModules ++ [
                ./hosts/ideapad.hm.nix
              ];
            }
          ];
      };
    };
}
