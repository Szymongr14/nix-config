{ inputs, ... }:
{
  # Wires home-manager into every darwin host (added to `base`).
  # After this, anything written under `flake.modules.homeManager.<name>` can be
  # picked up by a host's user via the import list in McDev/default.nix.
  flake.modules.darwin.base = { config, ... }: {
    imports = [
      inputs.home-manager.darwinModules.home-manager
    ];

    home-manager = {
      # false = HM uses its OWN nixpkgs (the one pinned via home-manager's input).
      useGlobalPkgs = false;
      useUserPackages = true;

      # If HM would overwrite an existing file (e.g. ~/.gitconfig you wrote by
      # hand), rename it to <file>.hm-backup instead of failing the activation.
      backupFileExtension = "hm-backup";

      # Pass `host` and the full system config down to every HM module.
      extraSpecialArgs = {
        inherit (config) host;
        osConfig = config;
      };

      users.${config.host.user.name} = {
        # Same state version semantics as system.stateVersion, but for HM.
        home.stateVersion = "25.11";
      };
    };
  };

  # Base options that every user gets — sets up the home directory, username,
  # and installs the `home-manager` CLI for ad-hoc inspection.
  flake.modules.homeManager.base = { pkgs, host, ... }: {
    home = {
      username = host.user.name;
      homeDirectory = "/Users/${host.user.name}";
      packages = [ pkgs.home-manager ];
      stateVersion = "25.11";
    };

    programs.home-manager.enable = true;
  };
}
