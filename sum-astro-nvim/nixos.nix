{ pkgs, ... }:
{
  imports = [
    ./common.nix
    ./fonts.nix
  ];
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    defaultEditor = true;
  };

}
