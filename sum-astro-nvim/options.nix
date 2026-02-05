{ lib, ... }:
{
  options.sumAstroNvim = with lib; {
    username = mkOption {
      type = types.str;
      description = "The user for whom SumAstroNvim will be installed";
    };
    nerdfont = mkOption {
      type = types.package;
      default = pkgs.nerd-font.lilex;
      description = "The Nerd Font to be used";
    };
    nodePackage = mkOption {
      type = types.package;
      defaultText = "nodejs_24";
      description = "The NodeJS version to be used";
    };
    pythonPackage = mkOption {
      type = types.package;
      defaultText = "python313Full";
      description = "The Python version to be used";
    };
  };
}
