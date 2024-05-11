{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;

  roles = config.my.roles;
  virt = config.my.system.virtualization;
in {
  config = mkIf (virt.enable && virt.docker.enable && roles.common) {
    environment.systemPackages = with pkgs; [docker-compose];
    virtualisation.docker.enable = true;
  };
}
