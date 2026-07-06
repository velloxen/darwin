{
  description = "Borealis nix-darwin system flake";

  inputs = {
    # NOTE: This nixpkgs commit (https://github.com/NixOS/nixpkgs/commit/ad97f5573d6621d4861bfdcfbd433ca08e86a188) made a breaking change, this nix-darwin issue (https://github.com/nix-darwin/nix-darwin/issues/1817) is resolving it. This nix-darwin PR (https://github.com/nix-darwin/nix-darwin/pull/1818) is the fix.
    # The easy solution is to just wait a day or two.
    nixpkgs.url = "github:NixOS/nixpkgs/97ed749796d9e3fbba376a1b3488193657ab356b";
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
