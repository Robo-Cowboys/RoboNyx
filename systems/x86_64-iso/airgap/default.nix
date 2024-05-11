{
  imports = [
    ./modules/roles.nix # Roles for this iso
    ./image # ISO image configuration
    ./system # system configuration
    ./virtualization # configure virtual machine

    ./yubikey.nix # configure yubikey toolkit
  ];

  config = {
    system.stateVersion = "23.11";
  };
}
