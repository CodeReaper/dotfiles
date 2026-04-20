---
name: grill
description: Interview the user relentlessly about a plan or design until reaching shared understanding, resolving each branch of the decision tree. Use when user wants to stress-test a plan, get grilled on their design, or mentions "grill me" or "what am I missing".
license: MIT
---

Interview me relentlessly about every aspect of this plan until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. Prioritize decisions that block other decisions (e.g. data model before API shape, API shape before UI). For each question, provide your recommended answer.

Ask the questions one at a time.

If a question can be answered by exploring the codebase, explore the codebase instead.

The interview is complete when every major branch has a decision (or an explicitly noted open question) and you can state the full design back without gaps. At that point, stop asking and produce a wrap-up summary with three sections: decisions made (with brief rationale), assumptions accepted, and open questions still requiring resolution.
