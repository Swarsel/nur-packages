  { self, lib, pkgs, ... }:
  let
    mkPackages = names: pkgs: builtins.listToAttrs (map
      (name: {
        inherit name;
        value = pkgs.callPackage "${self}/pkgs/general/${name}" { inherit self name; };
      })
      names);
    readNix = lib.filter (name: name != "default.nix") (lib.attrNames (builtins.readDir "${self}/pkgs/general"));
  in
  mkPackages readNix pkgs
