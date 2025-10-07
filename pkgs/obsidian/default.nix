  { self, lib, pkgs, ... }:
  let
    mkPackages = names: pkgs: builtins.listToAttrs (map
      (name: {
        inherit name;
        value = pkgs.callPackage "${self}/pkgs/obsidian/${name}" { inherit self name; };
      })
      names);
    readNix = lib.filter (name: name != "default.nix") (lib.attrNames (builtins.readDir "${self}/pkgs/obsidian"));
  in
  mkPackages readNix pkgs
