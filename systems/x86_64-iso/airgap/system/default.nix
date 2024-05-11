# NixOS livesystem to generate yubikeys in an air-gapped manner
# $ nix build .#images.airgap
{
  imports = [
    ./boot.nix
    ./environment.nix
    ./fonts.nix
    ./networking.nix
    ./programs.nix
    ./security.nix
    ./services.nix
    ./users.nix
  ];
}
