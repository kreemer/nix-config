{ ... }: {
  imports = builtins.filter (f: f != ./default.nix)
    (map (n: ./. + "/${n}")
      (builtins.filter (n: builtins.match ".*\\.nix" n != null)
        (builtins.attrNames (builtins.readDir ./.))
      )
    );
}
