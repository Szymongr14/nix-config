{
  flake.modules.homeManager.codexConfig = { ... }: {
    # Link AGENTS.md to ~/.codex/AGENTS.md — Codex picks it up as global
    # instructions (the OpenAI equivalent of Claude's CLAUDE.md).
    home.file.".codex/AGENTS.md".source = ./AGENTS.md;
  };
}
