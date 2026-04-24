{ neovim-pkgs, ... }:
let
  neovim = import neovim-pkgs {
    system = "x86_64-linux";
    config = { };
  };
in
{
  imports = [ ./common.nix ./fonts.nix ];
  config = {
    environment.systemPackages = [ neovim.neovim-unwrapped ];
  };
}
