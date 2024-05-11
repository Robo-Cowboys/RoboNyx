{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf (config.my.system.virtualization.enable && config.my.system.virtualization.docker.enable) {
    environment.systemPackages = with pkgs; [docker-compose];
    virtualisation.docker.enable = true;
  };
}
