{
  description = "SumAstroNvim Nix Implementation";
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-23.11";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, darwin, home-manager, ... }:
    {
      nixosModules = rec {
        astroNvim = import ./sum-astro-nvim/nixos.nix;
        defualt = astroNvim;
      };
      darwinModules = rec {
        astroNvim = import ./sum-astro-nvim/macos.nix;
        defualt = astroNvim;
      };
    };
}
