{ nixpkgs-unstable, ... }:
let
  unstable = import nixpkgs-unstable {
    system = "aarch64-darwin";
    config = { };
  };
in
{
  imports = [ ./common.nix ];
  config = {
    environment.systemPackages = [ unstable.neovim-unwrapped ];
  };
}
