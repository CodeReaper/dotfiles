#!/bin/sh

ralph_worker=$(cat "$(dirname "$0")/prompt-worker.md")
ralph_selection=$(cat "$(dirname "$0")/prompt-selection.md")

consecutive_empty=0
iteration=0
while [ "$iteration" -lt 10 ]; do
	iteration=$((iteration + 1))
	echo "=== Ralph iteration $iteration ==="

	result=$(opencode run --agent plan "$ralph_selection" | tee /dev/tty)
	if echo "$result" | grep -q "<promise>FINISHED</promise>"; then
		break
	fi

	task_path=$(echo "$result" | grep -o '<task>[^<]*</task>' | sed 's/<task>//;s/<\/task>//')
	prompt="$ralph_worker
Task file: $task_path"
	result=$(opencode run --agent build --dangerously-skip-permissions "$prompt" | tee /dev/tty)
	if echo "$result" | grep -q "<promise>COMPLETE</promise>"; then
		consecutive_empty=0
	else
		consecutive_empty=$((consecutive_empty + 1))
		if [ "$consecutive_empty" -ge 2 ]; then
			echo "Ralph loop ended (no progress for 2 iterations)"
			break
		fi
	fi
	echo ""
done
echo "Ralph loop ended"
