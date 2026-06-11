{
  config,
  inputs,
  self,
  ...
}:
let
  host = {
    name = "McDev";
    user.name = "szymongrrr";
    state = {
      darwin = 6;
    };
    system = "aarch64-darwin";
  };
in
{
  flake.darwinConfigurations.McDev = inputs.nix-darwin.lib.darwinSystem {
    system = host.system;
    specialArgs = { inherit inputs self; };
    modules = with config.flake.modules.darwin; [
      base
      McDev
      linux-builder  # uncomment to enable the Linux VM builder
    ];
  };

  flake.modules.darwin.McDev = {
    inherit host;

    nixpkgs.hostPlatform = host.system;

    # Set Git commit hash for darwin-version.
    system.configurationRevision = self.rev or self.dirtyRev or null;

    # Pick which home-manager modules this host's user gets.
    home-manager.users.${host.user.name} = {
      imports = with config.flake.modules.homeManager; [
        base
        git
        aerospace
        zsh
        claudeConfig
        codexConfig
      ];
    };
  };
}
