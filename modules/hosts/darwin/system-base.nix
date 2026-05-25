{
  # macOS system defaults and base system settings.
  #
  # Everything here is COMMENTED OUT on purpose — current macOS state is
  # untouched. When setting up a fresh Mac, uncomment what you want and
  # `darwin-rebuild switch` will apply it via `defaults write`.
  #
  # Reference (current options): https://daiderd.com/nix-darwin/manual/index.html
  flake.modules.darwin.base = { ... }: {
    # system.defaults = {
    #   NSGlobalDomain = {
    #     AppleInterfaceStyle = "Dark";
    #     KeyRepeat = 2;
    #     InitialKeyRepeat = 15;
    #     ApplePressAndHoldEnabled = false;
    #     NSAutomaticCapitalizationEnabled = false;
    #     NSAutomaticDashSubstitutionEnabled = false;
    #     NSAutomaticQuoteSubstitutionEnabled = false;
    #     NSAutomaticSpellingCorrectionEnabled = false;
    #     AppleShowAllExtensions = true;
    #   };
    #
    #   dock = {
    #     autohide = true;
    #     show-recents = false;
    #     mru-spaces = false;          # important for aerospace
    #     tilesize = 48;
    #     minimize-to-application = true;
    #     # orientation = "bottom";    # "bottom" | "left" | "right"
    #     # persistent-apps = [];      # list of .app paths
    #   };
    #
    #   finder = {
    #     AppleShowAllExtensions = true;
    #     AppleShowAllFiles = true;
    #     FXPreferredViewStyle = "clmv";   # column view
    #     ShowPathbar = true;
    #     ShowStatusBar = true;
    #     # NewWindowTarget = "PfHm";      # PfHm=Home, PfDe=Desktop, PfDo=Documents
    #   };
    #
    #   trackpad.Clicking = true;          # tap to click
    #   controlcenter.BatteryShowPercentage = true;
    #   screensaver.askForPasswordDelay = 0;
    #
    #   spaces.spans-displays = false;     # each display has its own spaces
    #
    #   # screencapture = {
    #   #   location = "/Users/szymongrrr/Documents/Screenshots";
    #   #   type = "png";
    #   #   disable-shadow = true;
    #   # };
    # };
    #
    # # Touch ID for sudo
    # security.pam.services.sudo_local.touchIdAuth = true;
    #
    # # System fonts (deployed by nix-darwin into /Library/Fonts)
    # fonts.packages = with pkgs; [
    #   nerd-fonts.fira-code
    #   nerd-fonts.jetbrains-mono
    # ];
  };
}
