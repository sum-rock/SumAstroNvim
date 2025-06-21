{ pkgs, config, ... }:
{
  config.fonts = {
    packages = [
      config.sumAstroNvim.nerdfont
      pkgs.font-awesome
    ];
  };
}
