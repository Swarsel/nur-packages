{ name, pkgs, ... }:

pkgs.stdenv.mkDerivation rec {
  inherit name;
  pname = "obsidian.plugins.${name}";
  version = "1.27.3";

  mainJs = pkgs.fetchurl {
    url = "https://github.com/scambier/obsidian-omnisearch/releases/download/${version}/main.js";
    sha256 = "sha256-OE9/vHLVjIkyIMFsLPTfv3kuFmfEtskMgPdmh2v9JWY=";
  };

  manifest = pkgs.fetchurl {
    url = "https://github.com/scambier/obsidian-omnisearch/releases/download/${version}/manifest.json";
    sha256 = "sha256-rNe++h6sFTyCAQWpLlBPjTscpK2+fNMS44hY90chUw4=";
  };

  stylesCss = pkgs.fetchurl {
    url = "https://github.com/scambier/obsidian-omnisearch/releases/download/${version}/styles.css";
    sha256 = "sha256-twt4bFGomeN2+5NpVPZVkIcJ/jy3RtmPG6H1FxhSris=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp $mainJs $out/main.js
    cp $manifest $out/manifest.json
    cp $stylesCss $out/styles.css
  '';
}
