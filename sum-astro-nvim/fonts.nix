{ pkgs, config, ... }:
{
  config.fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ config.sumAstroNvim.nerdfont ]; })
      font-awesome
    ];
  };
}
