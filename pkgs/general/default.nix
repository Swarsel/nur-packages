  { nixlib, pkgs, ... }:
  let
    mkPackages = names: pkgs: builtins.listToAttrs (map
      (name: {
        inherit name;
        value = pkgs.callPackage ./${name} { inherit name; };
      })
      names);
    readNix = nixlib.filter (name: name != "default.nix") (nixlib.attrNames (builtins.readDir ./. ));
  in
  mkPackages readNix pkgs
