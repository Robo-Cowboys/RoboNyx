{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkIf;

  sys = config.my.system.boot;
  roles = config.my.roles;
in {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  config = mkIf (sys.secureBoot && roles.common) {
    environment.systemPackages = [
      # For debugging and troubleshooting Secure Boot.
      pkgs.sbctl
    ];

    # Lanzaboote currently replaces the systemd-boot module.
    # This setting is usually set to true in configuration.nix
    # generated at installation time. So we force it to false
    # for now.
    boot.loader.systemd-boot.enable = lib.mkForce false;

    boot = {
      bootspec.enable = true;
      lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };
    };
  };
}