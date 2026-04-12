---
name: ralph
description: Create a ralph loop for doing concrete tasks
license: MIT
compatibility: opencode
---

Ralph is a technique for running AI coding agents in a loop. You run the same prompt repeatedly. The AI picks its own tasks.

## What I do

- Picks tasks from a list of tasks
- Prepares a structured prompt for selected tasks
- Asks agent to perform a single selected task
- Remembers the summaries of every performed task

## Preparation

Confirm you are in build mode and have read and write privileges otherwise you must REFUSE to start the loop.

Before starting the loop run all tests that the agents might run and REFUSE the start the loop if the tests does not pass.

## Tasks

Tasks are expected to be self-contained description in a file.

Task files are all considered the same priority, if not specified in the task file.

Task files dependencies can be specified in the task file, but if not,
it is up to the AI to find a task without unresolved dependencies.

Ask the human for guidance on finding the task files, if already not known.

Once a task is completed the task file MUST be deleted immediately.

## Picking tasks

Find the highest-priority task that does not have unresolved dependencies.
It does not have to the first task on the list.

## Structured prompts

The prompt should be:

```
Read your task at @path/to/task.md and implement it.
Work ONLY on the given task.
It is strictly FORBIDDEN to use the git tool directly for anything other than `git status *`.
Always remove files that are unintendedly created.
Run `test-command` to test after implementation.
If the implementation is done and tests pass, output <promise>COMPLETE</promise>.
Always output your progress briefly in <summary>...</summary>
```

... where the `@path/to/task.md` is the path to the selected task file and
`test-command` is the command required to run tests. The command for testing should always be provided.

## Agents

Start agents with the structured prompt, and (if it is not the first attempt at the selected task) additional helpful information to the agent based on previous summaries of the same selected task.

Only agents (and specifically not you) are allowed to work on tasks.

Start the agents with `opencode run --agent build --dangerously-skip-permissions [message]` where the `[message]` is the structured prompt.

## Summaries

You will remember the summary output from `<summary>...</summary>` from agents for as long as you are working on the same selected task, whenever you complete a task you will forget all previous summaries.

## Stopping

A maximum number of iterations is either provided or assumed to be 10 iterations.
Each attempt to perform a task counts towards the maximum iterations.

The loop will stop under these conditions:

- No tasks left
- No task could be selected
- All selectable tasks have failed to complete
- Maximum number of iterations reached
- The human provides a message to stop
