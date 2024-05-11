{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) my;
  sys = my.system;
  serv = sys.services;
in {
  config = mkIf (my.profiles.workstation.enable && serv.flatpak.enable) {
    services.flatpak.enable = true;
  };
}
