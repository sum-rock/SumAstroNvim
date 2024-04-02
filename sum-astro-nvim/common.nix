{ pkgs, system, config, lib, home-manger, ... }:
{
  imports = [ ./options.nix ];
  config = {
    environment.systemPackages = with pkgs; [
      # Essential
      neovim
      ripgrep
      lazygit
      gdu
      bottom
      # LSP dependencies
      stylua
      selene
      ruff
      config.sumAstroNvim.pythonPackage
      config.sumAstroNvim.nodePackage
      rustup # Must run `rustup default stable`
    ];
    home-manager.users.${config.sumAstroNvim.username}.xdg.configFile = {
      "nvim/lua" = {
        source = ../src/lua;
        recursive = true;
      };
      "nvim/init.lua" = {
        source = ../src/init.lua;
      };
    };
  };
}
