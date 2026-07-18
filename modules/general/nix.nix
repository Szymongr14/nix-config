{
  flake.modules.darwin.base = {
    nix = {
      settings = {
        experimental-features = "nix-command flakes";
        trusted-users = [ "root" "szymongrrr" ];

        # Extra binary caches — Nix downloads prebuilt artifacts from here
        # before falling back to local build.
        extra-substituters = [
          "https://cache.dartkit.pl/dartkitos"
          "https://nixos-raspberrypi.cachix.org"
        ];
        extra-trusted-public-keys = [
          "dartkitos:qbEVIC7PCAV2tfg+nUbUT9LqK30r6sdh9vOOcoiag40="
          "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
        ];
      };

      gc = {
        automatic = true;
        options = "--delete-older-than 30d";
        interval = {
          Weekday = 0;
          Hour = 2;
          Minute = 0;
        };
      };

      optimise = {
        automatic = true;
      };
    };
  };
}
