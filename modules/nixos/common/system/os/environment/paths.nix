{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  roles = config.my.roles;
in {
  config = mkIf roles.common {
    # enable completions for system packages
    # and other stuff
    environment.pathsToLink = [
      "/share/zsh" # zsh completions
      "/share/bash-completion" # bash completions
      "/share/nix-direnv" # direnv completions
    ];
  };
}
