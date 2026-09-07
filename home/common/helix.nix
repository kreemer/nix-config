{ pkgs, lib, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "monokai_pro_machine";
      mouse = false;
      true-color = true;
      editor = {
        soft-wrap = {
          enable = true;
        };
      };
      keys = {
        insert = {
          up = "no_op";
          down = "no_op";
          left = "no_op";
          right = "no_op";
        };
        normal = {
          C-j = [
            "extend_to_line_bounds"
            "delete_selection"
            "paste_after"
          ];
          C-k = [
            "extend_to_line_bounds"
            "delete_selection"
            "move_line_up"
            "paste_before"
          ];
          up = "no_op";
          down = "no_op";
          left = "no_op";
          right = "no_op";
        };
      };
    };

    languages = {
      language-server.rust-analyzer = {
        command = "rust-analyzer";
        config = {
          rustc = {
            source = "discover";
          };
        };
      };

      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = lib.getExe pkgs.nixfmt;
        }
        {
          name = "rust";
          language-servers = [ "rust-analyzer" ];
        }
      ];
    };

    themes = {
      autumn_night_transparent = {
        "inherits" = "autumn_night";
        "ui.background" = { };
      };
    };
  };
}
