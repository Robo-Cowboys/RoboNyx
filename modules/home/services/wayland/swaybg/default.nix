{
  pkgs,
  lib,
  osConfig,
  inputs,
  ...
}: let
  inherit (lib) mkIf getExe;
  inherit (osConfig) modules;
  inherit (lib) isWayland mkHyprlandService;

  env = modules.usrEnv;
  wallpkgs = inputs.wallpkgs.packages.${pkgs.system};
in {
  config = mkIf ((isWayland osConfig) && (env.wallpaperService == "swaybg")) {
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
