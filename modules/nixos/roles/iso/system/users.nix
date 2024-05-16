{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.modules.roles.iso {
    users.extraUsers.root.password = "";

    users.users.nixos = {
      password = "nixos";
      description = "default";
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };
}
