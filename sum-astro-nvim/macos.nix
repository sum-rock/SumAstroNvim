{ nixpkgs-neovim, nixpkgs, ... }:
let
  neovim-pkgs = import nixpkgs-neovim {
    system = "aarch64-darwin";
    config = { };
  };
  pkgs = import nixpkgs {
    system = "aarch64-darwin";
    config = { };
  };
in
{
  imports = [ ./common.nix ];
  config = {
    environment.systemPackages = [ neovim-pkgs.neovim-unwrapped ];
  };
}
