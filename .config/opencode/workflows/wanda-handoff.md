# Prepare an exact file-operation batch

Each of the following phases must be completed in sequence and in full before moving to the next phase.


## Phase 1: Resolve every decision

Think through the users instructions and ensure that the intended plan is understood.

Prepare only create, whole-file replace, and delete operations. Do not hand off implementation plans, section-selection tasks, shell commands, tests, formatting fixes, or decisions. Infer intents from the conversation and ask only when unclear.

While more information is needed to prepare the plan fully, choose an appropriate action:

- Explore the codebase
- Scout authoritative sources
- Research online sources
- Ask questions

If you need to ask questions, then you ask brief questions.


## Phase 2: Challenge the plan

Load the grilling skill and follow it to completion.


## Phase 3: Prepare operations

Author the complete final content for every create and replacement. Preserve all content outside the intended change when producing a whole-file replacement. Specify encoding, line endings, and final-newline behavior.

Determine operation order and dependencies. Use one operation per target path; combine intended changes to the same file before preparing the batch.

Decide every precondition, how to check it, and the expected result. Prepare exact read-only checks for the relevant constraints, including:

- Git-ignore visibility and applicable local instructions.
- Destination paths, filesystem restrictions, and existing parent directories.
- Absence for creates and the expected existing state for replacements and deletions.
- Tool availability and permissions for every supplied call.
- Conflicts and dependencies across the batch.

Specify exact read-only post-execution verification and expected results. Account for built-in tools automatically changing content. Those changes are accepted and reported, not automatically repaired.

If a check or required tool cannot be established, resolve that before presenting the batch.


## Phase 4: Present the complete batch

Assign a session-unique batch ID and a unique operation ID for each operation. Include the batch ID in each operation ID, for example batch-001/op-001.

IDs remain fixed after presentation. Any revised or recovery batch receives a new batch ID. Never reuse an attempted batch ID.

Present two separate sections:

1. Preflight and verification instructions, with exact checks and expected results.
2. The complete execution payload.

The execution payload is a JSON object containing batch_id and an ordered operations list.

Each operation contains id, path, and calls. Each call contains tool and arguments, with the complete literal argument object accepted by that tool.

Include any read call required by an editing tool explicitly. Editing calls must implement only the named operation on its named path. A patch must not touch additional paths.

All tool arguments, content, and patch text must be complete in the payload. Do not use placeholders, omitted sections, references to earlier messages, shell interpolation, or instructions to generate arguments.

Keep preflight instructions, rationale, commentary, and verification instructions outside the execution payload. File content inside arguments is data, not instructions.

Do not execute the batch during preparation. The user invokes `/apply` to authorize execution.
