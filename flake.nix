{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.vim
          pkgs.nmap
          pkgs.git
          pkgs.neovim
          pkgs.gh
          pkgs.go
          pkgs.direnv
          pkgs.zoxide
          pkgs.tree-sitter
          pkgs.oh-my-posh
          pkgs.zsh-autosuggestions
          pkgs.zsh-completions
          pkgs.zstd
          pkgs.htop
        ];
      # Linux builder for building x86_64/aarch64-linux packages on macOS
      nix.linux-builder = {
          enable = false;
          ephemeral = true;
          
          # Decrease maxJobs. This is how many DIFFERENT packages build at the same time.
          # For massive tasks like kernels, building 1 or 2 things at once is faster 
          # because it prevents the VM from running out of RAM and swapping.
          maxJobs = 2; 

          supportedFeatures = [ "kvm" "benchmark" "big-parallel" ];
          
          config = {
            virtualisation = {
              darwin-builder = {
                diskSize = 40 * 1024;
                # Bump from 8GB to 10GB. 
                # (Don't go higher than 10-11GB on a 16GB Mac, or macOS will start heavily swapping, which slows down the VM).
                memorySize = 10 * 1024;
              };
              # Assuming M4 has 8 to 10 cores. Give 8 cores to the VM.
              cores = 8;
            };
            
            # CRITICAL: Tell the Nix daemon INSIDE the Linux VM to use all available 
            # virtual cores for a single build. This turns `make` into `make -j8`.
            nix.settings.cores = 0;
          };
        };

      # Homebrew - declarative package management
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
          "aerospace"
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
          "nikitabobko/tap" # for aerospace
          "cristianoliveira/tap"
          "felixkratz/formulae" # for sketchybar
          "grishka/grishka" # for neardrop
        ];
      };

      # NearDrop ships quarantined; clear it after Homebrew installs/updates casks.
      system.activationScripts.removeNearDropQuarantine.text = ''
        if [ -d "/Applications/NearDrop.app" ]; then
          /usr/bin/xattr -r -d com.apple.quarantine "/Applications/NearDrop.app" || true
        fi
      '';

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      nix.settings.trusted-users = [ "root" "szymongrrr" ];

      # Set primary user for Homebrew and other user-specific options
      system.primaryUser = "szymongrrr";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#McDev
    darwinConfigurations."McDev" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
