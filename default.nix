{ pkgs ? import <nixpkgs> { } }:

let
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

in
pkgs.stdenv.mkDerivation rec {
  pname = "shellcheck";

  version = "0.8.0";

  src =
    if pkgs.stdenv.isDarwin
    then
      pkgs.fetchzip
        {
          url = "https://github.com/koalaman/shellcheck/releases/download/v0.8.0/shellcheck-v0.8.0.darwin.x86_64.tar.xz";
          sha256 = "156ixwnibc7cqyb1d2cx7x6gbydicy7smplz48aj6hihslymjdfi";
        }
    else
      pkgs.fetchzip {
        url = "https://github.com/koalaman/shellcheck/releases/download/v0.8.0/shellcheck-v0.8.0.linux.x86_64.tar.xz";
        sha256 = "0182kwgpk4vphy0pcmhqlj3lp6z22wj82aabpcb51pmd7kpc8drx";
      };

  dontStrip = true;

  installPhase = ''
    mkdir -p $out/bin
    SHELLCHECK=$out/bin/shellcheck

    install -D -m555 -T shellcheck $SHELLCHECK
  '';
}
