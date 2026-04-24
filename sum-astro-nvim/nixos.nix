{ nixpkgs-neovim, nixpkgs, ... }:
let
  neovim-pkgs = import nixpkgs-neovim {
    system = "x86_64-linux";
    config = { };
  };
  pkgs = import nixpkgs {
    system = "x86_64-linux";
    config = { };
  };
in
{
  imports = [ ./common.nix ./fonts.nix ];
  config = {
    environment.systemPackages = [ neovim-pkgs.neovim-unwrapped ];
  };
}
