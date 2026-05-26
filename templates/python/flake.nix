{
  description = "Python project (uv + Nix-managed interpreter)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs@{ flake-parts, systems, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;

      perSystem = { pkgs, ... }: {
        devShells.default = pkgs.mkShellNoCC {
          packages = with pkgs; [
            python312
            uv
          ];

          shellHook = ''
            # Force uv to use the Nix-provided Python instead of downloading
            # its own — keeps the env reproducible across machines.
            export UV_PYTHON=${pkgs.python312}/bin/python3
            export UV_PYTHON_PREFERENCE="only-system"
            export UV_PYTHON_DOWNLOADS="never"

            # Prevent host PYTHONPATH from leaking into the project venv.
            unset PYTHONPATH

            # Sync dependencies. `uv sync --frozen` uses uv.lock if present.
            if [ -f uv.lock ]; then
              uv sync --frozen
            else
              uv sync
            fi

            . .venv/bin/activate
          '';
        };
      };
    };
}
