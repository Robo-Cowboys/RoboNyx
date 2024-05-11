{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.my.system.activation = {
    diffGenerations = mkEnableOption "diff view between rebuilds";
  };
}
