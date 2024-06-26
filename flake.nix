{
    description = "NixOS configuration";

    # All inputs for the system
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    };

    # All outputs for the system (configs)
    outputs = { home-manager, nixpkgs, ... }@inputs: 
        let
            system = "x86_64-linux"; #current system
            pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
            lib = nixpkgs.lib;

            # This lets us reuse the code to "create" a system
            # Credits go to sioodmy on this one!
            # https://github.com/sioodmy/dotfiles/blob/main/flake.nix
            mkSystem = pkgs: system: hostname:
                pkgs.lib.nixosSystem {
                    system = system;
                    modules = [
                        { networking.hostName = hostname; }
                        # General configuration (users, networking, sound, etc)
                        ./configuration.nix
                        # Hardware config (bootloader, kernel modules, filesystems, etc)
                        # DO NOT USE MY HARDWARE CONFIG!! USE YOUR OWN!!
                        ./hardware-configuration.nix
                        home-manager.nixosModules.home-manager
                        {
                            home-manager = {
                                useUserPackages = true;
                                useGlobalPkgs = true;
                                extraSpecialArgs = { inherit inputs; };
                                # Home manager config (configures programs like firefox, zsh, eww, etc)
                                users.anton = ./home-anton/default.nix;
                                users.darny = ./home-darny/default.nix;
                                users.sorio = ./home-sorio/default.nix;
                                users.boulanger = ./home-boulanger/default.nix;
                            };
                        }
                    ];
                    specialArgs = { inherit inputs; };
                };

        in {
            nixosConfigurations = {
                grafix = mkSystem inputs.nixpkgs "x86_64-linux" "grafix";
            };
    };
}
