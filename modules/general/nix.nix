{
  flake.modules.darwin.base = {
    nix = {
      settings = {
        experimental-features = "nix-command flakes";
        trusted-users = [ "root" "szymongrrr" ];

        min-free = 20 * 1024 * 1024 * 1024;
        max-free = 50 * 1024 * 1024 * 1024;
        gc-reserved-space = 1024 * 1024 * 1024;

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
        options = "--delete-older-than 14d";
        interval = {
          Hour = 3;
          Minute = 0;
        };
      };

      optimise = {
        automatic = true;
      };
    };
  };
}
