{ pkgs, ... }:
{
  imports = [
    ./common.nix
    ./fonts.nix
  ];
  programs.nix-ld.libraries = with pkgs; [
    neovim
  ];

}
