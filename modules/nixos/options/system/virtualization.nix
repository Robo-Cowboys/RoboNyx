{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.my.system.virtualization = {
    enable = mkEnableOption "virtualization";
    libvirt = {enable = mkEnableOption "libvirt";};
    docker = {enable = mkEnableOption "docker";};
    podman = {enable = mkEnableOption "podman";};
    qemu = {enable = mkEnableOption "qemu";};
    waydroid = {enable = mkEnableOption "waydroid";};
    distrobox = {enable = mkEnableOption "distrobox";};
  };
}
