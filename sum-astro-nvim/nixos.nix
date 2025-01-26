{ pkgs, ... }:
{
  imports = [
    ./common.nix
    ./fonts.nix
  ];
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    neovim-unwrapped
  ];
  # programs.neovim = {
  #   enable = true;
  #   package = pkgs.neovim-unwrapped;
  #   defaultEditor = true;
  # };

}
