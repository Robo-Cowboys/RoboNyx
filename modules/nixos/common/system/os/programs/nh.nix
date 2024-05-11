{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  sys = config.my.system;
  roles = config.my.roles;
in {
  config = mkIf roles.common {
    # Useful package to simplify nix commands
    # https://github.com/viperML/nh
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 5";
      flake = "/home/${sys.mainUser}/.config/nyx";
    };
  };
}
