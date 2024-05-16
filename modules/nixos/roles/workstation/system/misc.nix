{
  lib,
  config,
  ...
}: let
  inherit (lib) mkForce;
in {
  config = {
    #  # Firefox cache on tmpfs
    #  fileSystems."/home/sincore/.cache/mozilla/firefox" = {
    #    device = "tmpfs";
    #    fsType = "tmpfs";
    #    noCheck = true;
    #    options = [
    #      "noatime"
    #      "nodev"
    #      "nosuid"
    #      "size=128M"
    #    ];
    #  };

    # enable the unified cgroup hierarchy (cgroupsv2)
    # NOTE: we use mkForce ensure that we are making cgroupsv2 the default
    # some services, i.e. lxd,  tries to disable it
    systemd.enableUnifiedCgroupHierarchy = mkForce true;
  };
}
