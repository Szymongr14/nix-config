{
  flake.modules.darwin.base = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      vim
      nmap
      git
      neovim
      gh
      go
      direnv
      zoxide
      tree-sitter
      oh-my-posh
      zsh-autosuggestions
      zsh-completions
      zstd
      htop
    ];
  };
}
