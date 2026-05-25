{
  flake.modules.darwin.base = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      vim
      nmap
      git
      neovim
      gh
      go
      tree-sitter
      zstd
      htop
    ];
  };
}
