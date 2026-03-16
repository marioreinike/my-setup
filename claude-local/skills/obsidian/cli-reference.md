# Obsidian CLI Command Reference

## Reading notes

```bash
obsidian read file="Note Name"
obsidian read path="folder/subfolder/Note.md"
obsidian daily:read
```

## Creating notes

```bash
obsidian create name="New Note" content="# Title\nBody text"
obsidian create name="New Post" template="Blog Post"
obsidian create name="Note" content="new content" --overwrite
```

## Editing notes (append/prepend)

```bash
obsidian append file="Log" content="- New entry"
obsidian prepend file="Inbox" content="- New item at top"
obsidian append file="Note" content=" extra text" inline
```

## Daily notes

```bash
obsidian daily                                    # Open today's note
obsidian daily:read                               # Read today's content
obsidian daily:append content="- [ ] New task"    # Append
obsidian daily:prepend content="## Morning"       # Prepend
obsidian daily:path                               # Get file path
```

## Searching

```bash
obsidian search query="meeting notes"
obsidian search:context query="error handling"    # Grep-style with line context
obsidian search query="project" limit=10
obsidian search query="review" format=json
obsidian search query="bug" path=Projects         # Within a folder
obsidian search query="API" case                  # Case-sensitive
```

## File management

```bash
obsidian files                                    # List all
obsidian files folder=Projects ext=md             # Filter
obsidian files total                              # Count
obsidian file file="Note"                         # File info
obsidian move file="Draft" to=Archive/2026/       # Move (updates links)
obsidian rename file="Old Name" name="New Name"   # Rename (updates links)
obsidian delete file="Note"                       # Trash
obsidian delete file="Note" --permanent           # Permanent
obsidian open file="Note"                         # Open in Obsidian
obsidian open file="Note" newtab
```

## Folders

```bash
obsidian folders
obsidian folders format=tree
obsidian folder path=Projects
```

## Tags

```bash
obsidian tags
obsidian tags sort=count counts
obsidian tag name=project                         # Notes with tag
obsidian tags format=json
```

## Properties (YAML frontmatter)

```bash
obsidian properties file="Note"
obsidian property:read file="Note" name=status
obsidian property:set file="Note" name=status value=active
obsidian property:set file="Note" name=due value=2026-03-20 type=date
obsidian property:set file="Note" name=tags value="pkm,obsidian" type=tags
obsidian property:remove file="Note" name=draft
```

## Tasks

```bash
obsidian tasks                                    # All tasks
obsidian tasks todo                               # Incomplete
obsidian tasks done                               # Completed
obsidian tasks daily                              # From daily note
obsidian tasks file="Project Plan"                # In specific file
obsidian tasks todo verbose                       # Grouped by file with line numbers
obsidian task path="Projects/Note.md" line=15 toggle
obsidian task file="Note" line=10 done
```

## Links and graph

```bash
obsidian links file="Note"                        # Outgoing links
obsidian backlinks file="Note"                    # Incoming links
obsidian unresolved                               # Broken links
obsidian orphans                                  # No incoming links
obsidian deadends                                 # No outgoing links
```

## Bookmarks

```bash
obsidian bookmarks
obsidian bookmark file="Important Note"
obsidian bookmark search="project status"
```

## Templates

```bash
obsidian templates
obsidian template:read name="Blog Post"
obsidian template:read name="Blog Post" resolve title="My Title"
```

## Outline

```bash
obsidian outline file="Note"
obsidian outline file="Note" format=tree
obsidian outline file="Note" format=json
```

## Vault info

```bash
obsidian vault
obsidian vault info=name
obsidian vault info=path
obsidian vault info=size
obsidian vaults
```

## Plugins

```bash
obsidian plugins
obsidian plugins:enabled
obsidian plugin:enable id=dataview
obsidian plugin:disable id=calendar
```

## Sync

```bash
obsidian sync:status
obsidian sync off
obsidian sync on
obsidian sync:history file="Note"
```
