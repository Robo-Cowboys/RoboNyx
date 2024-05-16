{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.modules.roles.microvm {
    environment.pathsToLink = ["/share/zsh"];
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions = {
        enable = true;
        async = true;
      };
    };
  };
}
