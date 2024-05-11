{
  lib,
  config,
  format,
  virtual,
  ...
}: let
  inherit (lib) mkOption;
  inherit (config.my) device;
in {
  #TODO: Fix the descriptions here.
  options.my.roles = {
    iso = mkOption {
      type = types.bool;
      default = format == "iso";
      description = ''
        Enables Packages specific to
      '';
    };

    headless = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Defines if the system is headless
      '';
    };

    graphical = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enables a Veriety of graphical packages.
      '';
    };

    server = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enables a Veriety of Server packages.
      '';
    };

    workstation = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enables a Veriety of workstation packages.
      '';
    };

    laptop = mkOption {
      type = types.bool;
      default = device.type == "laptop";
      description = ''
        Enables laptop options.
      '';
    };

    microvm = mkOption {
      type = types.bool;
      default = virtual;
      description = ''
        Enables microvm options.
      '';
    };
  };
}
