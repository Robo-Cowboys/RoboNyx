{
  config,
  lib,
  ...
}: {
  config = {
    # disable sound related programs
    sound.enable = mkForce false;
  };
}
