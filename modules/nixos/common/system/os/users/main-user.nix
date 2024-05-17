{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  #TODO: Update this so it's pulled from the main system config.
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICDSw8KwWzGDDks1fHSiuJO915PDXYdgKHpj+4+6XYrW sincore@jupiter"
  ];
  sys = config.modules.system;
in {
  config = {
    boot.initrd.network.ssh.authorizedKeys = keys;

    services.openssh = {
      enable = true;
      openFirewall = true;
      hostKeys = [
        {
          bits = 4096;
          path = "/etc/ssh/ssh_host_rsa_key";
          type = "rsa";
        }
        {
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };

    users.users."${sys.mainUser}" = {
      isNormalUser = true;
      shell = pkgs.zsh;
      initialPassword = "changeme";
      openssh.authorizedKeys.keys = keys;
      extraGroups = [
        "wheel"
        "gitea"
        "docker"
        "systemd-journal"
        "vboxusers"
        "audio"
        "plugdev"
        "video"
        "input"
        "lp"
        "networkmanager"
        "power"
        "nix"
      ];
      uid = 1000;
    };
  };
}
