{
  osConfig,
  pkgs,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.my) isWayland mkHyprlandService;
  inherit (osConfig) my;
  monitors = my.device.monitors;
  env = my.usrEnv;

  hyprpaper = inputs.hyprpaper.packages.${pkgs.system}.default;
  wallpkgs = inputs.wallpkgs.packages.${pkgs.system};
in {
  config = mkIf ((isWayland osConfig) && (env.desktops.wallpaperService == "hyprpaper")) {
    systemd.user.services.hyprpaper = mkHyprlandService {
      Unit.Description = "Hyprland wallpaper daemon";
      Service = {
        Type = "simple";
        ExecStart = "${lib.getExe hyprpaper}";
        Restart = "on-failure";
      };
    };
    xdg.configFile."hypr/hyprpaper.conf" = {
      text = let
        wallpaper = "${wallpkgs.catppuccin}/share/wallpapers/catppuccin/04.png";
      in ''
        preload=${wallpaper}
        ${builtins.concatStringsSep "\n" (builtins.map (monitor: ''wallpaper=${monitor},${wallpaper}'') monitors)}
        ipc=off
      '';
    };
  };
}
