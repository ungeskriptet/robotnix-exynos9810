{
  lib,
  pkgs,
  inputs,
  device,
}:
let
  patches = pkgs.runCommand "exynos9810-patches" { } ''
    mkdir -p $out
    ${lib.getExe pkgs.unzip} -j -d $out ${inputs.local-manifests}/PATCHES.zip
  '';
in
{
  inherit device;
  flavor = "lineageos";
  flavorVersion = "23.2";

  envVars = {
    WITH_GMS = "true";
  };

  source.dirs = {
    "device/samsung/crownlte".src = inputs.android-device-samsung-crownlte;
    "device/samsung/exynos9810-common".src = inputs.android-device-samsung-exynos9810-common;
    "device/samsung_slsi/sepolicy".src = inputs.android-device-samsung-slsi-sepolicy;
    "device/samsung/star2lte".src = inputs.android-device-samsung-star2lte;
    "device/samsung/starlte".src = inputs.android-device-samsung-starlte;
    "hardware/samsung_slsi-linaro/config".src = inputs.android-hardware-samsung-slsi-linaro-config;
    "hardware/samsung_slsi-linaro/exynos5".src = inputs.android-hardware-samsung-slsi-linaro-exynos5;
    "hardware/samsung_slsi-linaro/exynos".src = inputs.android-hardware-samsung-slsi-linaro-exynos;
    "hardware/samsung_slsi-linaro/graphics".src = inputs.android-hardware-samsung-slsi-linaro-graphics;
    "hardware/samsung_slsi-linaro/interfaces".src =
      inputs.android-hardware-samsung-slsi-linaro-interfaces;
    "hardware/samsung_slsi-linaro/openmax".src = inputs.android-hardware-samsung-slsi-linaro-openmax;
    "hardware/samsung_slsi/nfc".src = inputs.android-hardware-samsung-slsi-nfc;
    "hardware/samsung".src = inputs.android-hardware-samsung;
    "kernel/samsung/exynos9810".src = inputs.android-kernel-samsung-exynos9810;
    "packages/apps/PhhIms".src = inputs.ims;
    "vendor/extra".src = ./vendor-extra;
    "vendor/samsung/crownlte".src = inputs.proprietary-vendor-samsung-crownlte;
    "vendor/samsung/exynos9810-common".src = inputs.proprietary-vendor-samsung-exynos9810-common;
    "vendor/samsung/star2lte".src = inputs.proprietary-vendor-samsung-star2lte;
    "vendor/samsung/starlte".src = inputs.proprietary-vendor-samsung-starlte;
    "build/make".patches = [
      "${patches}/build_core_0001-build-Squash-of-allowing-a-device-to-generically-def.patch"
      "${patches}/build_core_0002-build-Add-support-for-device-tree-in-boot.img.patch"
      "${patches}/build_core_0003-Add-support-for-separate-kernels-for-boot-and-recove.patch"
      "${patches}/build_core_0004-build-Automatically-replace-old-style-kernel-header-.patch"
      "${patches}/build_core_0005-Replace-old-style-kernel-headers-only-when-building-.patch"
      "${patches}/build_core_0006-Replace-device_kernel_headers-with-generated_kernel_.patch"
    ];
    "build/soong".patches = [
      "${patches}/build_soong_0001-soong-allow-overriding-header-files.patch"
    ];
    "system/tools/mkbootimg".patches = [
      "${patches}/system_tools_mkbootimg_433617.diff"
    ];
    "external/cronet".patches = [ "${patches}/external_cronet_433320.diff" ];
    "vendor/partner_gms".src = inputs.android-vendor-partner-gms;
  };

  stateVersion = "3";
}
