{ neovim-pkgs, ... }:
let
  neovim = import neovim-pkgs {
    system = "aarch64-darwin";
    config = { };
  };
in
{
  imports = [ ./common.nix ];
  config = {
    environment.systemPackages = [ neovim.neovim-unwrapped ];
  };
}
