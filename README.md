# robotnix-exynos9810
Build LineageOS for Samsung Exynos 9810 devices using [robotnix](https://github.com/nix-community/robotnix)

Available devices:
- crownlte (Samsung Galaxy Note9, SM-N960F)
- star2lte (Samsung Galaxy S9+, SM-G965F)
- starlte (Samsung Galaxy S9, SM-G960F)

## Usage
```
nix build -L https://codeberg.org/ungeskriptet/robotnix-exynos9810/archive/master.tar.gz#robotnixConfigurations.<hostPlatform>.<device>.ota
```

## Sources
Thanks to [krazey](https://github.com/krazey) for creating the device trees!
