{
  description = "Fast open-source firmware for the PineTime smartwatch with many features, written in modern C++.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
    xc.url = "github:joerdav/xc";
  };
  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              (final: prev: {
                xc = inputs.xc.packages.x86_64-linux.xc;
              })
            ];
          };
        in
        {
          # Development shell (nix develop)
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              xc
              cmake
              gcc
              ccls
              gcc-arm-embedded
              openocd
              python39
              minicom
              gnumake
              gdb
              git
              cacert
            ];
          };
          # The firmware (nix build)
          packages.pinetime = pkgs.callPackage ./default.nix {
            gcc-arm-embedded = pkgs.gcc-arm-embedded-10;
            nrf5-sdk = pkgs.callPackage ./nrf5-sdk.nix { };
          };
        }
      );
}
