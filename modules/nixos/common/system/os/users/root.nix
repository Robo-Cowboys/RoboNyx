{
  config,
  lib,
  ...
}: {
  config = {
    users.users.root.hashedPassword = "*"; # lock root account
  };
}
