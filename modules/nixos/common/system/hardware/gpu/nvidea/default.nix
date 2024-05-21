{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkDefault mkMerge versionOlder;

  # use the latest possible nvidia package
  nvStable = config.boot.kernelPackages.nvidiaPackages.stable.version;
  nvBeta = config.boot.kernelPackages.nvidiaPackages.beta.version;

  nvidiaPackage =
    if (versionOlder nvBeta nvStable)
    then config.boot.kernelPackages.nvidiaPackages.stable
    else config.boot.kernelPackages.nvidiaPackages.beta;

  dev = config.modules.device;
  env = config.modules.usrEnv;
in {
  config = mkIf (builtins.elem dev.gpu.type ["nvidia" "hybrid-nv"]) {
    # nvidia drivers are unfree software
    nixpkgs.config.allowUnfree = true;

    services.xserver = mkMerge [
      {
        videoDrivers = ["nvidia"];
      }
    ];

    environment = {
      sessionVariables = mkMerge [
        {LIBVA_DRIVER_NAME = "nvidia";}

        (mkIf env.isWayland {
          WLR_NO_HARDWARE_CURSORS = "1";
        })

      ];
      systemPackages = with pkgs; [
#        nvtopPackages.nvidia
#
#        # mesa
#        mesa
#
#        # vulkan
#        vulkan-tools
#        vulkan-loader
#        vulkan-validation-layers
#        vulkan-extension-layer
#
#        # libva
#        libva
#        libva-utils
      ];
    };

    hardware = {
      nvidia = {
        # For people who want to use sync instead of offload. Especially for AMD CPU users
        prime.sync.enable = lib.mkOverride 990 true;
      };

      opengl = {
        extraPackages = with pkgs; [vaapiVdpau];
      };
    };
  };
}
