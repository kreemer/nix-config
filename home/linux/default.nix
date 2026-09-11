{ pkgs, ... }: {
  imports = builtins.filter (f: f != ./default.nix)
    (map (n: ./. + "/${n}")
      (builtins.filter (n: builtins.match ".*\\.nix" n != null)
        (builtins.attrNames (builtins.readDir ./.))
      )
    );

  home.file.".config/cosmic/com.system76.CosmicComp/v1/xkb_config".text = ''
    (
      rules: "",
      model: "",
      layout: "us",
      variant: "intl",
      options: None,
    )
  '';
  home.file.".config/cosmic/com.system76.CosmicComp/v1/xkb_config".force = true;

  home.packages = [ pkgs.fcitx5 ];

  systemd.user.services.fcitx5-daemon = {
    Unit = {
      Description = "Fcitx5 Daemon";
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "forking";
      ExecStart = "${pkgs.fcitx5}/bin/fcitx5 -d --replace";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
