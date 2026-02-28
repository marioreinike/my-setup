Restore configurations from this repo to the computer.

First, run `git pull origin main` to get the latest changes from the remote.

Then, compare ALL files before applying anything:
1. For each mapping in CLAUDE.md's File-to-System Mapping table, read the repo file and the live file on the computer
2. For claude-local/ files, compare against their ~/.claude/ counterparts
3. Build a summary of ALL changes (files that differ, new files, unchanged files)
4. Present the full summary to the user with diffs for each changed file
5. Ask for a single confirmation before applying all changes

Only after the user confirms, apply all changes:
- Copy each changed config to its live location
- Copy claude-local/settings.json → ~/.claude/settings.json
- Copy claude-local/plugins/*.json → ~/.claude/plugins/
- If claude-local/commands/ has files, copy them → ~/.claude/commands/
- Create parent directories if they don't exist

IMPORTANT:
- For zsh/zshrc: warn that CLAUDE_API_TOKEN and NPM_TASKFORCESH_TOKEN are redacted and must be set manually after restore
- Never overwrite ~/.claude/.credentials.json
