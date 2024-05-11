{
  pkgs,
  lib,
  osConfig,
  inputs,
  ...
}: let
  inherit (lib) mkIf getExe;
  inherit (osConfig) my;
  inherit (lib.my) isWayland mkHyprlandService;

  env = my.usrEnv;
  wallpkgs = inputs.wallpkgs.packages.${pkgs.system};
in {
  config = mkIf ((isWayland osConfig) && (env.desktops.wallpaperService == "swaybg")) {
    systemd.user.services = {
      swaybg = mkHyprlandService {
        Unit.Description = "Wallpaper chooser service";
        Service = let
          wall = "${wallpkgs.catppuccin}/share/wallpapers/catppuccin/01.png";
        in {
          ExecStart = "${getExe pkgs.swaybg} -i ${wall} -m center";
          Restart = "always";
        };
      };
    };
  };
}
