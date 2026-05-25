{
  flake.modules.homeManager.zsh = { config, pkgs, ... }: {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd" "cd" ];
    };

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      useTheme = null;  # we provide our own theme file via settings
      settings = builtins.fromJSON (
        builtins.readFile ./oh-my-posh/gruvbox.omp.json
      );
    };

    # Extra PATH entries (from the old .zshrc / .zshenv / .zprofile).
    home.sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.antigravity/antigravity/bin"
      "$HOME/.dotnet/tools"
      "$HOME/flutter/bin"
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;

      # Run on every interactive zsh shell.
      initContent = ''
        # Homebrew shellenv (login shell already runs this via .zprofile,
        # but interactive non-login shells need it too).
        if [ -x /opt/homebrew/bin/brew ]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
        fi

        # OrbStack integration.
        [ -f "$HOME/.orbstack/shell/init.zsh" ] && \
          source "$HOME/.orbstack/shell/init.zsh"
      '';
    };
  };
}
