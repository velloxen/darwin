{
  description = "Borealis nix-darwin system flake";

  inputs = {
    nixpkgs = {
      owner = "NixOS";
      repo = "nixpkgs";
      #ref = "nixpkgs-unstable";
      rev = "cbb5cf358f50aa6acc9efd6113b7bcfbc352cd73";
      type = "github";
    };
    #.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    #darwin.url = "github:nix-darwin/nix-darwin/master";
    darwin = {
      owner = "nix-darwin";
      repo = "nix-darwin";
      ref = "master";
      #rev = "6a771120d607dcccb279a27d227650e324815c35";
      type = "github";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      darwin,
      ...
    }@inputs:
    {
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
