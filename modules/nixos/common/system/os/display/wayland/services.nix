{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf getExe;

  cfg = config.my.system.video;
in {
  config = mkIf (cfg.enable && (lib.my.isWayland config)) {
    systemd.services = {
      seatd = {
        enable = true;
        description = "Seat management daemon";
        script = "${getExe pkgs.seatd} -g wheel";
        serviceConfig = {
          Type = "simple";
          Restart = "always";
          RestartSec = "1";
        };
        wantedBy = ["multi-user.target"];
      };
    };
  };
}
