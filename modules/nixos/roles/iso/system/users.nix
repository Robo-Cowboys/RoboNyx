{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.my.modules.iso {
    users.extraUsers.root.password = "";

    users.users.nixos = {
      password = "nixos";
      description = "default";
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };
}
