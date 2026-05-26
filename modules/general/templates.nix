{
  # `nix flake init -t /etc/nix-darwin#<name>` copies the matching template
  # directory into the current folder so you can bootstrap a new project.
  flake.templates = {
    default = {
      path = ../../templates/default;
      description = "Minimal devShell project template";
    };

    python = {
      path = ../../templates/python;
      description = "Python project with uv + Nix-managed interpreter";
    };
  };
}
