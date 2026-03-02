#!/bin/bash
# Pane process manager — list all tmux panes, kill (C-c) or jump to them
# Used as a tmux popup via prefix + X

JUMP_FILE="/tmp/.tmux-pane-manager-jump"
SELF="$(cd "$(dirname "$0")" && pwd)/$(basename "$0")"
CURRENT_PANE="${TMUX_PANE:-}"

STATE_DIR="/tmp/claude-agent-states"

# Get agent state for a TTY from hook state files
get_agent_state() {
  local tty="$1"
  [ -d "$STATE_DIR" ] || { echo "unknown"; return; }
  for sf in "$STATE_DIR"/*; do
    [ -f "$sf" ] || continue
    local s_state="" s_tty=""
    { read -r s_state; read -r s_tty; } < "$sf"
    if [ "$s_tty" = "$tty" ]; then
      echo "$s_state"
      return
    fi
  done
  echo "unknown"
}

list_panes() {
  # Detect TTYs running claude (shows as version number in pane_current_command)
  local claude_ttys
  claude_ttys=$(ps -eo tty=,comm= 2>/dev/null | awk '$2 == "claude" {print $1}')

  tmux list-panes -a -F '#{pane_id}|#{session_name}:#{window_name}.#{pane_index}|#{pane_current_command}|#{pane_current_path}|#{pane_tty}' 2>/dev/null \
    | while IFS='|' read -r pid loc cmd path tty; do
        short="${path/#$HOME/\~}"
        tty_short="${tty#/dev/}"
        is_claude=0
        echo "$claude_ttys" | grep -qx "$tty_short" && is_claude=1

        if [ "$is_claude" -eq 1 ]; then
          local state
          state=$(get_agent_state "$tty_short")
          local label color
          case "$state" in
            thinking) label="● thinking"; color="\033[32m" ;;
            waiting)  label="◆ waiting";  color="\033[33m" ;;
            idle)     label="○ idle";     color="\033[38;5;208m" ;;
            *)        label="claude";     color="\033[2m" ;;
          esac
          printf '%s|  %b%-28s  %-16s  %s\033[0m\n' "$pid" "$color" "$loc" "($label)" "$short"
        elif echo "$cmd" | grep -qE '^(zsh|bash|fish|sh)$'; then
          printf '%s|  \033[2m%-28s  %-16s  %s\033[0m\n' "$pid" "$loc" "$cmd" "$short"
        else
          printf '%s|  \033[1m%-28s  %-16s  %s\033[0m\n' "$pid" "$loc" "$cmd" "$short"
        fi
      done
}

# Called by fzf reload
if [ "$1" = "--list" ]; then
  list_panes
  exit 0
fi

rm -f "$JUMP_FILE"

# Find line number of current pane to pre-select it
default_pos=1
if [ -n "$CURRENT_PANE" ]; then
  line=0
  while IFS='|' read -r pid _rest; do
    line=$((line + 1))
    if [ "$pid" = "$CURRENT_PANE" ]; then
      default_pos=$line
      break
    fi
  done < <(list_panes)
fi

HEADER='  enter: jump  x: kill (C-c)  q: quit
  bold = running  dim = idle  ● thinking  ◆ waiting  ○ idle (claude)'

selected=$(list_panes | fzf \
  --header="$HEADER" \
  --delimiter='|' \
  --with-nth=2 \
  --nth=1 \
  --preview='tmux capture-pane -p -t {1} 2>/dev/null | tail -30' \
  --preview-window='right:50%:wrap' \
  --bind="x:execute-silent(tmux send-keys -t {1} C-c)+reload(bash $SELF --list)" \
  --ansi \
  --no-sort \
  --reverse \
  --no-info \
  --margin=1,2 \
  --prompt='  ' \
  --pointer='▸' \
  --color='pointer:cyan,header:dim')

if [ -n "$selected" ]; then
  pane_id=$(printf '%s' "$selected" | cut -d'|' -f1)
  if [ -n "$pane_id" ]; then
    sess=$(tmux display-message -t "$pane_id" -p '#{session_name}' 2>/dev/null)
    printf 'switch-client -t "%s"\nselect-window -t "%s"\nselect-pane -t "%s"\n' \
      "$sess" "$pane_id" "$pane_id" > "$JUMP_FILE"
  fi
fi
