{
  perSystem = _: {
    just-flake.features.hello = {
      enable = true;
      justfile = ''
        hello:
          echo Hello World
      '';
    };
  };
}
