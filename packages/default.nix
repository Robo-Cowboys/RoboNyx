{ inputs', ... }:

self: super: {
      nixSuper = inputs'.nix-super.packages.default;
      nixSchemas = inputs'.nixSchemas.packages.default;
      #TODO: Update this to recursivley grab packages from all child folders
      nordpass = self.callPackage ./nordpass { };
      orca-slicer = self.callPackage ./orca-slicer { };
}
