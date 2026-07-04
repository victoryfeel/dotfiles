#!/usr/bin/env bash

current="$(tmux display-message -p '#S')"

target="$(
	tmux list-sessions -F '#S' |
		grep -vxF "$current" |
		fzf --reverse
)"

[ -n "$target" ] && tmux switch-client -t "$target"
