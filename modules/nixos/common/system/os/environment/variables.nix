{config, ...}: let
  sys = config.my.system;
in {
  # variables that I want to set globally on all systems
  config = {
    environment.variables = {
      FLAKE = "/home/${sys.mainUser}/.config/nyx";
      SSH_AUTH_SOCK = "/run/user/\${UID}/keyring/ssh";

      # editors
      EDITOR = "nano";
      VISUAL = "nano";
      SUDO_EDITOR = "nano";
    };
  };
}
