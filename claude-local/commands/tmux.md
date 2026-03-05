# tmux Terminal Inspector

Inspect the user's tmux environment to understand what's running across all terminal panes. Use this for debugging, reading server logs, monitoring processes, and understanding the full workspace.

## Step 1: Discover all panes

Run this to get a full map of every tmux pane:

```bash
tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index} | cmd=#{pane_current_command} | pid=#{pane_pid} | path=#{pane_current_path} | title=#{pane_title} | active=#{pane_active} | #{pane_width}x#{pane_height}'
```

Key fields:
- `pane_current_command`: the foreground process (node, zsh, python, etc.)
- `pane_title`: often contains the full command line (e.g., "pnpm nest start", "pnpm dev")
- `pane_current_path`: working directory of the pane
- `pane_pid`: PID of the pane's shell process (use to find child processes)

## Step 2: Identify project-related panes

Compare each pane's `pane_current_path` with the current working directory (`$PWD` or the project root). A pane is project-related if:
- Its path matches or is a subdirectory of the current project
- Its path shares the same repo root (e.g., both under `/Users/mario/REPOS/backend`)

Classify each pane:
- **Server**: `pane_current_command` is `node`, `python`, `ruby`, `java`, `go`, `cargo`, `uvicorn`, `gunicorn`, `next-server`, etc.
- **Claude agent**: `pane_current_command` matches a version pattern like `2.1.68` or contains `claude`
- **Shell**: `pane_current_command` is `zsh`, `bash`, `fish`, `sh`
- **Tool**: anything else (vim, htop, lazygit, etc.)

## Step 3: Read pane output

To read a pane's visible output (last N lines):
```bash
tmux capture-pane -t <session:window.pane> -p -S -<lines>
```

Examples:
```bash
# Last 100 lines from a specific pane
tmux capture-pane -t main:1.1 -p -S -100

# Full scrollback history (can be very large)
tmux capture-pane -t main:1.1 -p -S -

# Just the visible screen
tmux capture-pane -t main:1.1 -p
```

Always start with `-S -200` for good context. If the user needs more, use `-S -`.

## Step 4: Get process tree for a pane

To see exactly what's running inside a pane (useful for servers):
```bash
ps -o pid,ppid,command -g <pane_pid> 2>/dev/null
```

This reveals child processes like the actual server, watchers, compilers, etc.

## Step 5: Search pane output

To find specific errors, patterns, or log entries:
```bash
tmux capture-pane -t <target> -p -S - | grep -i "<pattern>"
```

For context around matches:
```bash
tmux capture-pane -t <target> -p -S - | grep -i -B5 -A5 "<pattern>"
```

## Step 6: Send commands to a pane

To interact with a pane (restart server, run a command):
```bash
# Send Ctrl+C to stop a process
tmux send-keys -t <target> C-c

# Wait briefly, then send a new command
tmux send-keys -t <target> "<command>" Enter
```

Common pattern to restart a server:
```bash
tmux send-keys -t <target> C-c && sleep 1 && tmux send-keys -t <target> "<start command>" Enter
```

## Step 7: Present findings

Organize by relevance to the user's current work:

1. **Project panes** (matching current directory): servers, shells, agents
2. **Server panes** across all sessions
3. **Other active panes**

For each pane show: location, what's running, path, and status.

If any server panes have errors in their output, proactively flag them.

## Debugging patterns

| User says | What to do |
|---|---|
| "check the logs" / "check the server" | Find server panes for current project → read their output |
| "there's an error" / "something crashed" | Read all project server panes → search for error/exception/stack trace |
| "restart the server" | Find the server pane → send C-c → send the start command |
| "what's running" | List all panes with classification |
| "read pane X" | Capture output from the specified pane |
| "run X in the server pane" | Find the right pane → send keys |

## Now: auto-inspect

Run Step 1 now. Identify panes related to the current working directory. If there are server panes for this project, read their last 50 lines. Present a concise summary of the terminal environment relevant to the current task.
