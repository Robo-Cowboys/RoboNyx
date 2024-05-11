{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib) getExe;
  inherit (lib.my) isWayland mkHyprlandService;
  inherit (osConfig) my;
  sys = my.system;
  prg = sys.programs;

  waylandFlags =
    if (isWayland osConfig)
    then "--enable-features=UseOzonePlatform --ozone-platform=wayland"
    else "";
in {
  config = mkIf (prg.signal-desktop.enable && (isWayland osConfig)) {
    home.packages = with pkgs; [
      signal-desktop
    ];

    systemd.user.services = {
      signaldesktop = mkHyprlandService {
        Unit.Description = "Signal Messenger";
        Service = {
          ExecStart = "${getExe pkgs.signal-desktop} ${waylandFlags}";
          Restart = "always";
        };
      };
    };
  };
}
