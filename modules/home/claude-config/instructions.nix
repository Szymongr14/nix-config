{
  flake.modules.homeManager.claudeConfig = { ... }: {
    # Link the in-repo CLAUDE.md to ~/.claude/CLAUDE.md so Claude Code picks
    # it up as global instructions. Edit the file in the repo, run
    # `darwin-rebuild switch`, done.
    home.file.".claude/CLAUDE.md".source = ./CLAUDE.md;
  };
}
