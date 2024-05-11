{
  lib,
  config,
  ...
}:
with lib; let
  inherit (lib) mkIf;
  inherit (config.my) roles;
in {
  imports = [
    ./touchpad.nix
  ];

  config = mkIf roles.laptop {
    powerManagement.enable = true;

    services = {
      logind = {
        lidSwitch = "suspend-then-hibernate";
        lidSwitchExternalPower = "suspend-then-hibernate";
        extraConfig = ''
          HandlePowerKey=suspend-then-hibernate
          HibernateDelaySec=3600
        '';
      };

      upower.enable = true;
    };
  };
}
