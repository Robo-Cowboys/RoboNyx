{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib) getExe';
  inherit (lib.my) isWayland mkHyprlandService;
  inherit (osConfig) my;
  sys = my.system;
  prg = sys.programs;
  #  waylandFlags =
  #    if (isWayland osConfig)
  #    then "--enable-features=UseOzonePlatform --ozone-platform=wayland"
  #    else "";
in {
  config = mkIf (prg.nordpass.enable && (isWayland osConfig)) {
    home.packages = with pkgs; [
      nordpass
    ];

    systemd.user.services = {
      nordpass = mkHyprlandService {
        Unit.Description = "Nordpass";
        Service = {
          ExecStart = "${getExe' pkgs.nordpass "nordpass"} --use-tray-icon";
          Restart = "always";
        };
      };
    };
  };
}
