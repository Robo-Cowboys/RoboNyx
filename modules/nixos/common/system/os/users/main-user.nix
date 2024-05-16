{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  #TODO: Update this so it's pulled from the main system config.
  keys = [
      # Ubuntu key
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAXXUIUO43Ta9R0vdYb8mRxh1tGpD8b5ExnE3y8XwuCV nurd"
      # NixOS key
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOAMRygHsDzFOKXtfuiufsRiLtg4Er4R8cElBB9p/etk nerd"
  ];
  sys = config.my.system;
  roles = config.my.roles;
in {
  config = mkIf roles.common {
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
