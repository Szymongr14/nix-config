{
  flake.modules.darwin.base = {
    homebrew = {
      enable = true;
      onActivation.cleanup = "uninstall"; # Remove unlisted packages

      brews = [
        "sketchybar"
        "cristianoliveira/tap/aerospace-scratchpad"
        "cocoapods"
      ];

      casks = [
        "rive"
        "codexbar"
        "wispr-flow"
        "firefox"
        "rstudio"
        "antigravity"
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
        "grishka/grishka/neardrop"
        "visual-studio-code"
        "yaak"
      ];

      taps = [
        "cristianoliveira/tap"
        "felixkratz/formulae"  # for sketchybar
        "grishka/grishka"      # for neardrop
      ];
    };

    # NearDrop ships quarantined; clear it after Homebrew installs/updates casks.
    system.activationScripts.removeNearDropQuarantine.text = ''
      if [ -d "/Applications/NearDrop.app" ]; then
        /usr/bin/xattr -r -d com.apple.quarantine "/Applications/NearDrop.app" || true
      fi
    '';
  };
}
