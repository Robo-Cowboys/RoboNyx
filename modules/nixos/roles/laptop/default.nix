{
  lib,
  config,
  ...
}:
with lib; let
  inherit (config.my) device;
in {
  imports = [
    ./touchpad.nix
  ];

  config = lib.mkIf (device.type == "laptop") {
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
