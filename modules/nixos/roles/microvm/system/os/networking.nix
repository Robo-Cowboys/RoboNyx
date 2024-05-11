{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.my.modules.microvm {
    systemd.network.enable = true;

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    networking = {
      useDHCP = false;
      networkmanager.enable = false;
      firewall = {
        enable = true;
        allowPing = lib.mkForce false;
        allowedTCPPorts = lib.mkForce [];
        allowedUDPPorts = lib.mkForce [];
      };
    };
  };
}
