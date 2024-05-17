{lib, ...}: let
  inherit (lib.snowfall) fs;
in {
  getSecretFile = file: fs.get-file "secrets/${file}";
  getSharedModule = name: fs.get-file "modules/shared/${name}";
  getSSHKeyFiles = user:
    fs.get-files (lib.snowfall.fs.get-file "keys/${user}/ssh");
}
