{
  flake.modules.darwin.base = {
    nix = {
      settings = {
        experimental-features = "nix-command flakes";
        trusted-users = [ "root" "szymongrrr" ];
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
