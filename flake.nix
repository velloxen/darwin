{
    description = "Borealis nix-darwin system flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

        darwin.url = "github:nix-darwin/nix-darwin/master";
        darwin.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = {
        self,
        nixpkgs,
        darwin,
        ...
    } @ inputs: {
        # Build darwin flake using:
        # $ darwin-rebuild build --flake .#Borealis
        darwinConfigurations."Borealis" = darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            pkgs = import nixpkgs {
                system = "aarch64-darwin";
                config.allowUnfree = true;
            };
            modules = [
                ./hosts/Borealis/configuration.nix
            ];
        };
    };
}
