#!/bin/sh

consecutive_empty=0
iteration=0
input=$(printf '%s ' "$@")
while [ "$iteration" -lt 5 ]; do
	iteration=$((iteration + 1))
	echo "=== Ralph iteration $iteration ==="

	selection="$(cat "$(dirname "$0")/prompt-selection.md")\n\n$input"
	result=$(opencode run --agent plan --title "Ralph - selection -> $input" "$selection" | tee /dev/tty)
	if echo "$result" | grep -q "<promise>FINISHED</promise>"; then
		break
	fi

	task_output=$(echo "$result" | grep -o '<task>[^<]*</task>' | sed 's/<task>//;s/<\/task>//')
	if [ -z "$task_output" ]; then
		echo "error: unable to select a task"
		break
	fi

	prompt="$(cat "$(dirname "$0")/prompt-worker.md")\n"
	if [ -f "$task_output" ]; then
		prompt="$prompt\nTask file: $task_output"
	else
		prompt="$prompt\nTask id: $task_output"
	fi

	result=$(opencode run --agent build --dangerously-skip-permissions --title "Ralph - worker - $task_output" "$prompt" | tee /dev/tty)
	if echo "$result" | grep -q "<promise>COMPLETE</promise>"; then
		consecutive_empty=0
	else
		consecutive_empty=$((consecutive_empty + 1))
		if [ "$consecutive_empty" -ge 2 ]; then
			echo "error: no progress for 2 iterations"
			break
		fi
	fi
	echo ""
done
echo "Ralph loop ended"
