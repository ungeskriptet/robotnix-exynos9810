{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    robotnix.url = "github:ungeskriptet/robotnix/lineage-update";
    android-kernel-samsung-exynos9810 = {
      url = "github:ExyHyperBrick/android_kernel_samsung_exynos9810/lineage-23.2-bpf-test";
      flake = false;
    };

    android-device-samsung-exynos9810-common = {
      url = "github:ExyHyperBrick/android_device_samsung_exynos9810-common/lineage-23.2";
      flake = false;
    };

    android-device-samsung-starlte = {
      url = "github:ExyHyperBrick/android_device_samsung_starlte/lineage-23.2";
      flake = false;
    };

    android-device-samsung-star2lte = {
      url = "github:ExyHyperBrick/android_device_samsung_star2lte/lineage-23.2";
      flake = false;
    };

    android-device-samsung-crownlte = {
      url = "github:ExyHyperBrick/android_device_samsung_crownlte/lineage-23.2";
      flake = false;
    };

    proprietary-vendor-samsung-exynos9810-common = {
      url = "github:ExyHyperBrick/proprietary_vendor_samsung_exynos9810-common/lineage-23.2";
      flake = false;
    };

    proprietary-vendor-samsung-crownlte = {
      url = "github:ExyHyperBrick/proprietary_vendor_samsung_crownlte/lineage-23.2";
      flake = false;
    };

    proprietary-vendor-samsung-star2lte = {
      url = "github:ExyHyperBrick/proprietary_vendor_samsung_star2lte/lineage-23.2";
      flake = false;
    };

    proprietary-vendor-samsung-starlte = {
      url = "github:ExyHyperBrick/proprietary_vendor_samsung_starlte/lineage-23.2";
      flake = false;
    };

    android-device-samsung-slsi-sepolicy = {
      url = "github:LineageOS/android_device_samsung_slsi_sepolicy/lineage-23.2";
      flake = false;
    };

    android-hardware-samsung = {
      url = "github:LineageOS/android_hardware_samsung/lineage-23.2";
      flake = false;
    };

    android-hardware-samsung-slsi-linaro-config = {
      url = "github:LineageOS/android_hardware_samsung_slsi-linaro_config/lineage-23.2";
      flake = false;
    };

    android-hardware-samsung-slsi-linaro-exynos = {
      url = "github:LineageOS/android_hardware_samsung_slsi-linaro_exynos/lineage-23.2";
      flake = false;
    };

    android-hardware-samsung-slsi-linaro-exynos5 = {
      url = "github:LineageOS/android_hardware_samsung_slsi-linaro_exynos5/lineage-23.2";
      flake = false;
    };

    android-hardware-samsung-slsi-linaro-graphics = {
      url = "github:LineageOS/android_hardware_samsung_slsi-linaro_graphics/lineage-23.2";
      flake = false;
    };

    android-hardware-samsung-slsi-linaro-interfaces = {
      url = "github:LineageOS/android_hardware_samsung_slsi-linaro_interfaces/lineage-23.2";
      flake = false;
    };

    android-hardware-samsung-slsi-linaro-openmax = {
      url = "github:LineageOS/android_hardware_samsung_slsi-linaro_openmax/lineage-23.2";
      flake = false;
    };

    android-hardware-samsung-slsi-nfc = {
      url = "github:LineageOS/android_hardware_samsung_slsi_nfc/lineage-23.2";
      flake = false;
    };

    android-vendor-partner-gms = {
      url = "git+https://gitlab.com/itsvixano-dev/android/lineageos-personal/android_vendor_partner_gms.git?ref=main";
      flake = false;
    };

    ims = {
      url = "git+https://github.com/krazey/ims?ref=main&submodules=1";
      flake = false;
    };

    local-manifests = {
      url = "github:ExyHyperBrick/local_manifests/lineage-23.2-wip";
      flake = false;
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      robotnix,
      ...
    }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
      ];
    in
    {
      robotnixConfigurations = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          lib = pkgs.lib;
          mkRobotnix =
            devices:
            lib.mergeAttrsList (
              map (device: {
                ${device} = robotnix.lib.robotnixSystem (
                  import ./exynos9810.nix {
                    inherit
                      lib
                      pkgs
                      inputs
                      device
                      ;
                  }
                );
              }) devices
            );
        in
        mkRobotnix [
          "crownlte"
          "star2lte"
          "starlte"
        ]
      );
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
