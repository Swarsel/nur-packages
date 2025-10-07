{ name, pkgs, ... }:
pkgs.stdenv.mkDerivation rec {
  pname = "obsidian.plugins.${name}";
  version = "0.3.1";

  src = pkgs.fetchFromGitHub {
    owner = "ganesshkumar";
    repo = "obsidian-table-editor";
    rev = version;
    hash = "sha256-Sumfrl+d/4/LOcl4TrcKmSiWJcUrHw/f7/GsZEJgxNE=";
  };

  offlineCache = pkgs.fetchYarnDeps {
    yarnLock = src + "/yarn.lock";
    hash = "sha256-ssCrQcdYrqTWSqz5Gek0gO5EfF85uRZhmnrIun7cVbA=";
  };

  nativeBuildInputs = with pkgs; [
    nodejs
    yarnConfigHook
    yarnBuildHook
    npmHooks.npmInstallHook
  ];

  installPhase = ''
    mkdir -p $out
    cp ./manifest.json $out/manifest.json
    cp ./main.js $out/main.js
    cp ./styles.css $out/styles.css
  '';
}
