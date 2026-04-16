1. Find tasks (described in agents.md) and pick ONE highest-priority task with no unresolved dependencies
2. If no tasks remain:
   - Output: <promise>FINISHED</promise>
3. Else:
   - Output: <promise>COMPLETE</promise>
   - Include: <task>id</task>

Rules:

- Pick ONE task only
- Avoid reading additional files - you are picking based on the tasks and the feature it represents
- It is strictly forbidden to use git directly (except `git status`)
