# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This repo is Mario's personal dotfiles/setup repository. It stores all computer configurations and Claude Code configurations as a single source of truth. When Mario asks to update a configuration, the workflow is:

1. **Read** the current config from the live location on the computer
2. **Modify** the config as requested (on the computer if instructed, or just in the repo)
3. **Update** the corresponding file in this repo
4. **Commit** the change with a short, precise message

## Repo Structure

```
git/          → Git config (~/.gitconfig) and global gitignore (~/.config/git/ignore)
zsh/          → Zsh shell config (~/.zshrc) and Powerlevel10k theme (~/.p10k.zsh)
atuin/        → Atuin shell history config (~/.config/atuin/config.toml)
gh/           → GitHub CLI config (~/.config/gh/config.yml)
zed/          → Zed editor settings and keymap (~/.config/zed/)
1password/    → 1Password SSH agent config (~/.config/1Password/ssh/agent.toml)
claude/       → Claude Code global settings (copy of ~/.claude/settings.json)
```

## File-to-System Mapping

| Repo file | Live location |
|---|---|
| `git/gitconfig` | `~/.gitconfig` |
| `git/gitignore_global` | `~/.config/git/ignore` |
| `zsh/zshrc` | `~/.zshrc` |
| `zsh/p10k.zsh` | `~/.p10k.zsh` |
| `atuin/config.toml` | `~/.config/atuin/config.toml` |
| `gh/config.yml` | `~/.config/gh/config.yml` |
| `zed/settings.json` | `~/.config/zed/settings.json` |
| `zed/keymap.json` | `~/.config/zed/keymap.json` |
| `1password/ssh-agent.toml` | `~/.config/1Password/ssh/agent.toml` |
| `claude/settings.json` | `~/.claude/settings.json` |

## Commit Conventions

- Keep commits atomic: group related changes logically
- Messages should be short and precise (e.g., "add lazygit alias to zshrc", "update delta side-by-side config")
- Always use `Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>` trailer

## Security

- **Never commit secrets** (API tokens, passwords, keys)
- The `zsh/zshrc` file has `CLAUDE_API_TOKEN` and `NPM_TASKFORCESH_TOKEN` redacted with `# REDACTED - set this manually`
- If adding new env vars with secrets to zshrc, always redact them in the repo copy

## Oh My Zsh Details

- Framework: Oh My Zsh at `~/.oh-my-zsh`
- Theme: `powerlevel10k/powerlevel10k` (custom theme)
- Plugins: `git`, `zsh-autosuggestions`, `zsh-syntax-highlighting` (last two are custom plugins)

## Key Shell Aliases

- `lg` → lazygit, `lgs` → lazygit with delta side-by-side
- `lt` → `ls -lht`
- `py` → python3, `tf` → terraform
- `cdwt <branch>` → navigate to git worktree by branch name
- Git: `pl`=pull, `ps`=push, `cm`=commit -m, `s`=status, `ch`=checkout, `l`=log --oneline

## Claude Code Skills and Commands

Claude skills/commands are stored at `~/.claude/commands/` (user-level) or in project `.claude/commands/` directories. Currently no custom skills exist. When Mario asks to create skills, save them both to `~/.claude/commands/` and to a `claude/commands/` directory in this repo.

## Adding New Configurations

When a new tool config needs tracking:
1. Create a new directory in the repo named after the tool
2. Copy the config file(s) with secrets redacted
3. Add the mapping to the table above (edit this CLAUDE.md)
4. Commit with a descriptive message
