{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  packages = [
    pkgs.dotnetCorePackages.sdk_10_0
    pkgs.fastfetch
  ];
}
