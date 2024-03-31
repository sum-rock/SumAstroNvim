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
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    src = {
      url = "./src";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, darwin, home-manager, flake-utils, src, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs =
          if (system == "aarch64-darwin")
          then darwin.legacyPackages.${system}
          else nixpkgs.legacyPackages.${system};
      in
      {
        nixosModules = {
          astroNvim =
            { pkgs, system, config, lib, home-manger, ... }:
            let
              cfg = config.sumAstroNvim;
            in
            {
              options.sumAstroNvim = with pkgs.lib; {
                username = mkOption {
                  type = types.str;
                  description = "The user for whom SumAstroNvim will be installed";
                };
                nerdfont = mkOption {
                  type = types.str;
                  default = "Lilex";
                  description = "The Nerd Font to be used";
                };
                nodePackage = mkOption {
                  type = types.package;
                  defaultText = "nodejs_20";
                  description = "The NodeJS version to be used";
                };
                pythonPackage = mkOption {
                  type = types.package;
                  defaultText = "python311Full";
                  description = "The Python version to be used";
                };
              };
              config = {
                environment.systemPackages = with pkgs; [
                  # Essential
                  neovim
                  ripgrep
                  lazygit
                  gdu
                  bottom
                  # LSPs 
                  lua53Packages.lua-lsp
                  stylua
                  # LSP dependencies
                  cfg.nodePackage
                  rustup # Must run `rustup default stable`
                ];
                # fonts = pkgs.lib.mkIf (config.system == "x86_64-linux") {
                #   packages = with pkgs; [
                #     (nerdfonts.override { fonts = [ cfg.nerdfont ]; })
                #     font-awesome
                #   ];
                # };
                home-manager.users.${cfg.username}.xdg.configFile = {
                  "nvim/" = {
                    source = "${src}";
                    recursive = true;
                  };
                };
              };
            };
        };
      }
    );
}
    
