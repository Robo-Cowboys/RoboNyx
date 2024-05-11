{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
in {
  #TODO: Fix the descriptions here.
  options.my.roles = {
    common = mkOption {
      type = types.bool;
      default = true;
      description = ''
        If you want to include all common settings under nixos then this should be enabled.
      '';
    };

    iso = mkOption {
      type = types.bool;
      default = false;
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
      default = false;
      description = ''
        Enables laptop options.
      '';
    };

    microvm = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enables microvm options.
      '';
    };
  };
}
