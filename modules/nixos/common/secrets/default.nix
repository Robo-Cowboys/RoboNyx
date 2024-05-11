{lib, ...}: {
  imports = [
    (lib.my.getSharedModule "secrets")
  ];
}
