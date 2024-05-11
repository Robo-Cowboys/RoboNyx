{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf forEach;

  sys = config.my.system;
  cfg = config.my.system.impermanence;
in {
  config = mkIf cfg.enable {
    fileSystems."/etc/ssh" = {
      depends = ["/persistent"];
      neededForBoot = true;
    };
    environment.persistence."/persistent" = {
      hideMounts = true;
      directories =
        [
          "/var/log"
          "/var/db/sudo"
        ]
        ++ forEach ["nixos" "NetworkManager" "nix" "ssh" "secureboot"] (x: "/etc/${x}")
        ++ forEach ["bluetooth" "nixos" "pipewire" "libvirt" "fail2ban" "fprint" "flatpak" "tailscale"] (x: "/var/lib/${x}");
      files = ["/etc/machine-id"];
    };
    # for some reason *this* is what makes networkmanager not get screwed completely instead of the impermanence module
    systemd.tmpfiles.rules = [
      "L /var/lib/NetworkManager/secret_key - - - - /persistent/var/lib/NetworkManager/secret_key"
      "L /var/lib/NetworkManager/seen-bssids - - - - /persistent/var/lib/NetworkManager/seen-bssids"
      "L /var/lib/NetworkManager/timestamps - - - - /persistent/var/lib/NetworkManager/timestamps"
    ];

    programs.fuse.userAllowOther = true;
    environment.persistence."/persistent" = {
      users."${sys.mainUser}" = {
        directories =
          [
            "Downloads"
            "Music"
            "Games"
            "Pictures"
            "Documents"
            "Videos"
            "source"
            {
              directory = ".gnupg";
              mode = "0700";
            }
            {
              directory = ".ssh";
              mode = "0700";
            }
            {
              directory = ".keepass";
              mode = "0700";
            }
            {
              directory = ".local/share/keyrings";
              mode = "0700";
            }
            ".var/app"
          ]
          #TODO This should be centrilized as well.
          ++ forEach ["google-chrome" "orca-slicer" "flatpak"] (x: ".cache/${x}")
          ++ forEach ["direnv" "flatpak"] (x: ".local/share/${x}")
          ++ forEach ["nyx" "NordPass" "Signal" "OrcaSlicer" "JetBrains" "google-chrome" "sops"] (x: ".config/${x}");
        files = [
          #                ".screenrc"
          #                ".config/spotify/prefs"
          #                ".config/spotify/Users/fuzen-py/prefs"
        ];
      };
    };

    boot.initrd.systemd.services.rollback = {
      description = "Rollback BTRFS root subvolume to a pristine state";
      wantedBy = ["initrd.target"];
      # make sure it's done after encryption
      # i.e. LUKS/TPM process
      after = ["systemd-cryptsetup@encrypted.service"];
      # mount the root fs before clearing
      before = ["sysroot.mount"];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        mkdir /btrfs_tmp
        # partlabel are generated by disko.
        mount /dev/disk/by-partlabel/disk-main-luks /btrfs_tmp

        sv='@'

        mkdir -p "/btrfs_tmp/snapshots/$sv"
        timestamp=$(date --date="@$(stat -c %Y "/btrfs_tmp/$sv")" "+%Y-%m-%-d_%H:%M:%S")
        mv "/btrfs_tmp/$sv" "/btrfs_tmp/snapshots/$sv/$timestamp"

        umount /btrfs_tmp
      '';
    };
  };
}
