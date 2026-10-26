---
name: code-readability
description: Guide for code and documentation so code is easy to scan and hard to misunderstand. Use when writing, changing, or reviewing code.
---

Code is written to be read as well as executed. Make its concepts and data flow clear. Keep names and layout concise without losing meaning. Document knowledge that code cannot communicate clearly. Omit commentary that merely repeats the code.

Help callers avoid reading the implementation. Help maintainers avoid rediscovering the reasoning behind it.

## Project conventions

Follow explicit user instructions, established project conventions, and language idioms. Use this guidance as defaults where those leave a choice. Before changing code, inspect relevant formatting, linting, and style configuration, including `.editorconfig`. Follow the formatter configured for the project and the syntax rules of the language.

## Tell the story

Read the code vertically, in execution order. Names and logical groupings should explain how inputs become results without requiring readers to repeatedly look up declarations.

## Naming

Choose the shortest clear name in context, not the most descriptive name in isolation.

- Default to one word for local variables.
- Add words only when needed to distinguish purpose, units, state, ownership, or relationships.
- Remove qualifiers that merely repeat obvious surrounding context.
- Name values for their role in the operation and include implementation details only when readers need them.
- Use consistent domain vocabulary and do not introduce synonyms for variety.
- Preserve distinctions such as `source` / `destination`, `original` / `normalized`, and `pending` / `completed`.

A second word earns its place by adding necessary meaning — not only by resolving a naming collision.

### Context and scope

Judge a name where it is used, not just where it is declared.

- Short local scopes can rely on nearby context.
- Names used across larger scopes or far from their declarations generally need more context.
- Names at the interface of a module must make sense to callers without requiring knowledge of its implementation.
- Names inside an implementation may rely on context hidden from callers.

For example:

- Use `service` rather than `apiService` when the API qualifier adds nothing in that scope.
- Use `apiClient` and `idClient` when their distinct roles matter.

### Abbreviations and casing

Avoid invented or obscure abbreviations. Allow widely understood abbreviations such as `id`, `db`, `url`, and `api`. Also allow conventional names in the language when their meaning is immediately clear.

Treat abbreviations like ordinary words within compound names:

- `ApiService`, not `APIService`
- `HttpRequest`, not `HTTPRequest`
- `apiClient`, not `aPIClient`
- `urlRequest`, not `uRLRequest`

Apply the casing convention used by the project to the complete name.

### Functions and methods

Describe the operation and its effect. Read names at their call sites to check that they support the surrounding narrative.

### Constants

Use named constants for values that represent meaningful rules, limits, or shared configuration defaults. Keep literals when their meaning is obvious locally. Group related constants when appropriate for the language.

### Naming difficulty

An unwieldy name may indicate an overloaded scope, confused concepts, or implementation knowledge leaking through an interface.

Investigate before adding words. Do not assume that either shortening the name or restructuring the code is automatically the answer.

## Interface documentation

- Use the appropriate documentation syntax for the language on the relevant declaration.
- Document caller obligations and guarantees, including constraints, ordering, ownership, side effects, error behavior, concurrency, and significant performance characteristics where relevant.
- Cover public interfaces and internal interfaces whose correct use requires non-obvious knowledge.
- Describe observable behavior rather than narrating implementation steps.
- Do not repeat information already evident from the name or type signature.

Clear names and structure do not replace documentation of non-obvious interface obligations and guarantees.

## Implementation commentary

- First consider whether clearer names or simpler code would remove the need for a comment.
- When necessary, explain rationale, invariants, compatibility constraints, or surprising behavior.
- Prefer declaration documentation when the information belongs with that declaration.
- Otherwise, place a standalone comment immediately before the relevant code.
- Do not add trailing commentary.
- Do not move implementation-only knowledge into interface documentation merely to satisfy placement rules.

## Design signals

Documentation that requires callers to understand internal steps may indicate a shallow module. Flag that design concern rather than introducing abstractions or restructuring code solely to eliminate a comment. A clear such design signal is local comments inside implementation.

## Line layout

When wrapping a call argument list across multiple lines, put each argument on its own line:

```go
result := calculate(
    firstArgument,
    secondArgument,
    thirdArgument,
)

resp, err := send(result)
```

Group logically related lines with a blank line between groups.

Do not insert blank lines mechanically after every statement or call.

## File organization

Do not split or combine files solely to meet a line-count target. Organize code around cohesive responsibilities and ease of navigation.

## Comment syntax and maintenance

- Prefer line comments. Use block comments only when required by documentation conventions, language semantics, tooling, or legal requirements.
- Preserve the required syntax and placement of functional comments, including compiler directives, build constraints, lint suppressions, and generated-file markers.
- Remove commented-out code, redundant narration, and stale explanations.
- Preserve useful rationale and non-obvious constraints.
- Use `TODO:` for deferred technical debt and state the remaining work.
- Use `FIXME:` to mark incomplete or incorrect work in the current implementation. State what must be finished or corrected, and resolve it before merging into a main or release branch.

## Change discipline

Apply these principles to code being changed. Avoid unrelated renaming, formatting churn, compatibility-breaking interface changes, and comment-only cleanup solely to enforce style.
