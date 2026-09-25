---
name: terminology-md
description: Build and sharpen a project's domain model. Use when discussing codebase terminology, writing or editing a TERMINOLOGY.md.
---

# Domain Modeling

Actively build and sharpen the project's domain model as you design. This is the _active_ discipline: challenging terms, inventing edge-case scenarios, and writing the glossary and decisions down the moment they crystallize. (Merely _reading_ `TERMINOLOGY.md` for vocabulary is not this skill: that's a one-line habit any skill can do. This skill is for when you're changing the model, not just consuming it.)

## File structure

Most repos have a single domain with a `TERMINOLOGY.md` at the root.

If a `TERMINOLOGY-CATALOG.md` exists at the root, the repo has multiple domains. The catalog describes each domain, links to where its terminology lives, and records how the domains relate:

```
/
├── TERMINOLOGY-CATALOG.md
├── src/
│   ├── ordering/
│   │   └── TERMINOLOGY.md    TERMINOLOGY-CATALOG.md links to this file
│   └── billing/
│       └── TERMINOLOGY.md    TERMINOLOGY-CATALOG.md links to this file
```

Create files lazily: only when you have something to write. If no `TERMINOLOGY.md` exists for the relevant domain, create one when the first term is resolved. In a multi-domain repo, add its link and description to `TERMINOLOGY-CATALOG.md`.

## During the session

### Challenge against the glossary

When the user uses a term that conflicts with the existing language in the relevant `TERMINOLOGY.md`, call it out immediately. "Your glossary defines 'cancellation' as X, but you seem to mean Y. Which is it?"

### Sharpen fuzzy language

When the user uses vague or overloaded terms, propose a precise canonical term. "You're saying 'account': do you mean the Customer or the User? Those are different things."

### Discuss concrete scenarios

When domain relationships are being discussed, stress-test them with specific scenarios. Invent scenarios that probe edge cases and force the user to be precise about the boundaries between concepts.

### Cross-reference with code

When the user states how something works, check whether the code agrees. If you find a contradiction, surface it: "Your code cancels entire Orders, but you just said partial cancellation is possible. Which is right?"

### Update TERMINOLOGY.md inline

When a term is resolved, update the relevant `TERMINOLOGY.md` right there. Don't batch these up: capture them as they happen. Use the format in [TERMINOLOGY-FORMAT.md](./TERMINOLOGY-FORMAT.md).

`TERMINOLOGY.md` should be totally devoid of implementation details. Do not treat it as a spec, a scratch pad, or a repository for implementation decisions. It is a glossary and nothing else.

### Update AGENTS.md

When at the repository root an `AGENTS.md` is present and does not reference the `TERMINOLOGY.md` or, for multi-domain repos, the `TERMINOLOGY-CATALOG.md`, offer to add a reference with a relative link. This ensures other agents with a different skill set can benefit from the registered domain concepts.

**Single domain (most repos):**

Suggested addition would be:

```md
For work involving domain terms, their meanings, preferred wording, or concept relationships, read the [TERMINOLOGY.md](./TERMINOLOGY.md) in the repository root first. Use the terminology file as the source of domain vocabulary; it does not describe implementation.
```

**Multiple domains:**

Suggested addition would be:

```md
For work involving domain terms, their meanings, preferred wording, or concept relationships, read the [TERMINOLOGY-CATALOG.md](./TERMINOLOGY-CATALOG.md) in the repository root first. Resolve links in the catalog relative to the catalog file, then read the terminology file for your domain. Use these files as the source of domain vocabulary; they do not describe implementation.
```
