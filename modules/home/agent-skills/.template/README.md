# Skill template

Skills defined here are automatically linked into BOTH `~/.claude/skills/`
AND `~/.codex/skills/` by `agent-skills.nix`. One source, two agents.

How to add a new skill:

1. Copy this directory to a sibling with the real skill name (kebab-case):

   ```sh
   cp -r modules/home/agent-skills/.template \
         modules/home/agent-skills/my-skill
   ```

2. Edit `my-skill/SKILL.md`:
   - Update the `name:` field to match the folder name.
   - Rewrite `description:` to be specific (Claude/Codex use this to decide
     whether to invoke the skill).
   - Fill in the body.

3. Delete this `README.md` from your new skill folder.

4. Stage the new files so Nix flake can see them:

   ```sh
   git -C /etc/nix-darwin add modules/home/agent-skills/my-skill
   ```

5. Apply:

   ```sh
   sudo darwin-rebuild switch --flake /etc/nix-darwin#McDev
   ```

After activation, the skill appears at both:
- `~/.claude/skills/my-skill/`
- `~/.codex/skills/my-skill/`

The `.template` folder is **never** linked — `agent-skills.nix` skips any
folder starting with `.`.
