{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  roles = config.my.roles;
in {
  config = mkIf roles.common {
    sops = {
      defaultSopsFile = lib.my.getSecretFile "default.yaml";
      age = {
        sshKeyPaths = lib.mkDefault ["/etc/ssh/ssh_host_ed25519_key"];
        keyFile = "/var/lib/sops-nix/key.txt";
        generateKey = true;
      };
    };
  };
}
