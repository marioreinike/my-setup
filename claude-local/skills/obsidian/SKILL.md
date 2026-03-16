---
name: obsidian
description: Interact with the user's Obsidian vault. Use when the user asks to read, create, edit, search, or manage notes, tasks, tags, daily notes, or vault structure. Keywords - notes, vault, obsidian, daily note, journal, PKM.
allowed-tools: Read, Edit, Write, Bash, Glob, Grep
---

# Obsidian Vault Manager

**Vault:** Yo — `/Users/mario/Library/Mobile Documents/iCloud~md~obsidian/Documents/Yo/`

Obsidian desktop must be running for CLI commands. File tools work regardless.

## CLI setup

```bash
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"
```

## CLI syntax

```
obsidian <command> [param=value] [--flags]
```

- `file="Name"` (wikilink resolution) or `path="folder/Note.md"` (exact path)
- `format=json|csv|tsv|yaml|md|paths|tree|text`
- `\n` for newline, `\t` for tab in content values
- Single vault — no need for `vault=Yo`
- Run `obsidian help` or `obsidian help <command>` for discovery

Full command reference: [cli-reference.md](cli-reference.md)

## How to handle requests

| User wants to | How |
|---|---|
| Read a note | CLI `read file="X"` or Read tool on vault file |
| Search / find notes | CLI `search query="X"` or `search:context query="X"` |
| Find by tag | CLI `tag name=X` |
| Daily note content | CLI `daily:read` |
| Add to a note / daily | CLI `append` or `daily:append` |
| Create simple note | CLI `create name="X" content="..."` |
| Create complex note | Write tool to vault path |
| Edit specific sections | CLI `search` to locate → Read tool → Edit tool on vault file |
| Move / rename | CLI only (`move`, `rename`) — preserves internal links |
| Tasks, links, backlinks, orphans | CLI only |
| Properties (frontmatter) | CLI `property:set`, `property:read` |
| Bulk-edit / restructure a note | Read + Edit tools on vault file |
| Vault structure | CLI `folders format=tree` |
