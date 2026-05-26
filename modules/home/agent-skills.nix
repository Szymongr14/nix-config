{ lib, ... }:
let
  skillsDir = ./agent-skills;

  # Every directory under ./agent-skills/ that contains a SKILL.md is a real
  # skill. Directories starting with "." (e.g. .template) are skipped so the
  # template never gets shipped as a real skill.
  skillNames = lib.filter
    (name:
      !(lib.hasPrefix "." name)
      && lib.pathExists (skillsDir + "/${name}/SKILL.md"))
    (lib.attrNames (builtins.readDir skillsDir));

  mkLinks = targetPrefix:
    lib.listToAttrs (map
      (name: {
        name = "${targetPrefix}/${name}";
        value.source = skillsDir + "/${name}";
      })
      skillNames);
in
{
  # Same set of skills is linked into both Claude's and Codex's skill dirs.
  # Sources live under ./agent-skills/, so a single edit updates both agents.
  flake.modules.homeManager.claudeConfig = {
    home.file = mkLinks ".claude/skills";
  };

  flake.modules.homeManager.codexConfig = {
    home.file = mkLinks ".codex/skills";
  };
}
