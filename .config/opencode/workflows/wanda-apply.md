Use the specified batch, or Wanda’s latest complete batch in this session. Reject ambiguous, superseded, incomplete, or previously attempted batches.

Run its prepared preflight checks; stop if any fail.

Send only its execution payload to one new Cosmo subagent.

Run the prepared read-only verification. Accept and report automatic built-in tool changes.

Summarize progress and errors by operation ID, preserving unknown outcomes. Do not replay an interrupted batch.

Authorization ends with this invocation; recovery requires a new batch and `/apply`.
