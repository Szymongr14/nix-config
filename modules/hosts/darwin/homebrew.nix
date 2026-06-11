{
  flake.modules.darwin.base = {
    homebrew = {
      enable = true;
      onActivation.autoUpdate = true;
      onActivation.cleanup = "uninstall"; # Remove unlisted packages
      onActivation.extraFlags = [ "--force-cleanup" ];

      brews = [
        "sketchybar"
        "can1357/tap/omp"
        "cristianoliveira/tap/aerospace-scratchpad"
        "cocoapods"
      ];

      casks = [
        "codexbar"
        "wispr-flow"
        "firefox"
        "alt-tab"
        "android-platform-tools"
        "android-studio"
        "discord"
        "dotnet-sdk"
        "freecad"
        "ghostty"
        "hiddenbar"
        "karabiner-elements"
        "middleclick"
        "obs"
        "onlyoffice"
        "orbstack"
        "prusaslicer"
        "raycast"
        "signal"
        "stats"
        "tailscale-app"
        "visual-studio-code"
        "yaak"
      ];

      taps = [
        "can1357/tap"
        "cristianoliveira/tap"
        "felixkratz/formulae"  # for sketchybar
      ];
    };
  };
}
