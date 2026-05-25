{ lib, ... }:
with lib;
let
  hostOptions = {
    name = mkOption {
      type = types.str;
      example = "McDev";
      description = "Host (machine) name";
    };

    user.name = mkOption {
      type = types.str;
      example = "szymongrrr";
      description = "Host username";
    };

    state = mkOption {
      type = types.submodule {
        options = {
          darwin = mkOption {
            type = types.int;
            example = 6;
            description = "Nix-Darwin state version";
          };
        };
      };
    };

    system = mkOption {
      type = types.str;
      example = "aarch64-darwin";
      description = "System architecture";
    };

    isDarwin = mkOption {
      type = types.bool;
      default = false;
      description = "If Darwin";
    };
  };
in
{
  flake.modules.darwin.base = {
    options.host = hostOptions;
    config.host.isDarwin = lib.mkDefault true;
  };
}
