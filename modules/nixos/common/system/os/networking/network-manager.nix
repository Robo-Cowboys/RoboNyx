{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  roles = config.my.roles;
in {
  config = mkIf roles.common {
    # we use networkmanager manage network devices locally
    networking.networkmanager = {
      enable = true;
      #    plugins = mkForce []; # disable all plugins, we don't need them
      unmanaged = [
        "interface-name:tailscale*"
        "interface-name:br-*"
        "interface-name:rndis*"
        "interface-name:docker*"
        "interface-name:rndis*"
        "interface-name:virbr*"
      ];
    };
  };
}