# Show task details

Run:

```
# dot show <id>
dot show dots-1a2b3c4d5e6f7890
```

Example output:

```
ID:       dots-1a2b3c4d5e6f7890
Title:    Design API
Status:   open
Priority: 1
Desc:     Cache responses based on status code. Lots of more
description of implementation guidance here.

**Notes:**

- Cache 2xx and 3xx responses
- Do not cache 4xx, 5xx, 599+

**Acceptance Criteria:**

- 2xx/3xx responses cached
- 4xx/5xx/599+ not cached

**Labels:**

- label: F007
- label: cache
- label: phase1
Created: 2024-12-24T10:30:00Z
```

Note:

- "Desc" can be multi-lined.
- "Acceptance Criteria" subsection is optional.
- "Labels" subsection is optional and are likely irrelevant for implementation.
