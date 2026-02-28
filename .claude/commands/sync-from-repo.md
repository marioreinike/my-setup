Restore configurations from this repo to the computer. Ask for confirmation before overwriting each file.

For each mapping in CLAUDE.md's File-to-System Mapping table:
1. Read the repo file
2. Read the live file on the computer (if it exists)
3. Show the diff
4. Ask for confirmation before copying

For claude-local/ (restore to ~/.claude/):
1. Copy claude-local/settings.json → ~/.claude/settings.json
2. Copy claude-local/plugins/*.json → ~/.claude/plugins/
3. If claude-local/commands/ has files, copy them → ~/.claude/commands/

IMPORTANT:
- For zsh/zshrc: warn that CLAUDE_API_TOKEN and NPM_TASKFORCESH_TOKEN are redacted and must be set manually after restore
- Never overwrite ~/.claude/.credentials.json
- Create parent directories if they don't exist
