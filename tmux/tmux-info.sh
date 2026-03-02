#!/usr/bin/env bash
echo ""
echo "  $(pwd)"
echo ""
if git rev-parse --is-inside-work-tree &>/dev/null; then
  echo "  Branch: $(git branch --show-current 2>/dev/null)"
  echo ""
  git status -sb 2>/dev/null | sed 's/^/  /'
  echo ""
  echo "  Last: $(git log -1 --oneline 2>/dev/null)"
fi
echo ""
read -rsn1 </dev/tty
