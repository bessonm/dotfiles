with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "gen-cursor-them";
  buildInputs = [
    xorg.xcursorgen
    inkscape
  ];
}
