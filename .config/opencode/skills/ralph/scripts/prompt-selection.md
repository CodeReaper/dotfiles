1. Find tasks (described in agents.md) and pick ONE highest-priority task with no unresolved dependencies
2. If no tasks remain:
   - Output: <promise>FINISHED</promise>
3. Else:
   - Output: <promise>COMPLETE</promise>
   - Include: <task>path/to/task/file</task>

Rules:

- Pick ONE task only
- It is strictly forbidden to use git directly (except `git status`)
