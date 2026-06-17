{
  description = "LaTeX project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, systems, pre-commit-hooks, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;

      perSystem = { pkgs, system, ... }: let
        preCommitCheck = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          default_stages = [
            "pre-commit"
            "pre-push"
          ];
          hooks = {
            check-added-large-files = {
              enable = true;
              args = [ "--maxkb=1000" ];
            };
            check-case-conflicts.enable = true;
            check-executables-have-shebangs.enable = true;
            end-of-file-fixer.enable = true;
            mixed-line-endings.enable = true;
            trim-trailing-whitespace.enable = true;
            check-toml.enable = true;
            check-yaml = {
              enable = true;
              excludes = [ "^(.*\\.j2\\.yml)$" ];
            };
            check-json.enable = true;
            pretty-format-json = {
              enable = true;
              args = [
                "--autofix"
                "--top-keys=version,metadata"
              ];
            };
            check-merge-conflicts.enable = true;
            commitizen.enable = true;
            alejandra.enable = true;
          };
        };
      in {
        devShells.default = pkgs.mkShellNoCC {
          inherit (preCommitCheck) shellHook;

          packages = with pkgs; [
            texliveFull
          ];
        };

        checks = {
          pre-commit-check = preCommitCheck;
        };
      };
    };
}
