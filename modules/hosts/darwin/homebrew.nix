{
  flake.modules.darwin.base = {
    homebrew = {
      enable = true;
      onActivation.autoUpdate = true;
      onActivation.cleanup = "none";
      onActivation.extraFlags = [ "--force-cleanup" ];

      brews = [
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
      ];

      extraConfig = ''
        brew "can1357/tap/omp", trusted: true
        brew "cristianoliveira/tap/aerospace-scratchpad", trusted: true
      '';
    };
  };
}
