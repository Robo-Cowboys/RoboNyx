{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.my.profiles.workstation.enable {
    programs.adb.enable = true;

    services.udev = {
      packages = [
        pkgs.android-udev-rules
      ];

      extraRules = ''
        # add my android device to adbusers
        SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666", GROUP="adbusers"
      '';
    };
  };
}
