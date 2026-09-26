# CODEBASE.md Format


## Single-codebase document

Use a root `CODEBASE.md` for most repositories:

```md
# Codebase Map

## Overview

{A concise summary or orientation to what this codebase does and its broad shape. The overview is an explicit exception: it is neither Evidence nor Fact and must contain only a concise summary.}

## {Area or concern}

- {A concise, comment-supported Evidence. It is unlabelled.}
- FACT: {A concise fact, supplied by a maintainer, and presumed true until a maintainer says it can be removed.}

## {Another area or concern, when useful}

- {A consequential integration constraint, fragile behavior, incomplete implementation, or unusual testing/release instruction supported by comments. It is unlabelled.}
- FACT: {A maintainer-provided integration constraint, fragile behavior, incomplete implementation, or unusual testing/release instruction.}
```

Only include sections for which there is useful content. Section headings should orient the reader to areas or concerns, not enumerate technologies, dependencies, classes, or files.


## Multi-domain catalog

Use `CODEBASE-CATALOG.md` only when the repository has multiple cohesive areas with distinct responsibilities or workflows, and separate maps would make its codebase knowledge easier to navigate and maintain. Folders, packages, services, or deployment boundaries alone do not establish separate domains. The catalog has a concise whole-codebase overview, links only to domains with at least one Evidence entry or Fact, and has a dedicated section for genuine cross-domain concerns. A domain overview alone does not qualify it for a map file or catalog link. The overview is an explicit exception: it is neither Evidence nor Fact and must contain only a concise summary. Other substantive catalog content is Evidence or Fact. Avoid duplicating entries across the catalog and domain maps.

```md
# Codebase Catalog

## Overview

{A concise summary or orientation to the codebase as a whole. The overview is an explicit exception: it is neither Evidence nor Fact and must contain only a concise summary.}

## Domains

- [Ordering](./ordering/CODEBASE.md): {Concise orientation to a domain with at least one Evidence entry or Fact.}
- [Billing](./billing/CODEBASE.md): {Concise orientation to a domain with at least one Evidence entry or Fact.}

## Cross-domain concerns

- {A genuine cross-domain concern supported by comments. It is unlabelled.}
- FACT: {Fact: a maintainer-provided consequential boundary or dependency.}
```

Each domain file uses the single-codebase document structure, with an overview scoped to that domain. Put domain-specific Evidence or Facts in the relevant domain map. Put concerns that genuinely span multiple domains in the catalog's dedicated cross-domain section.

The domain links above are illustrative. Include a domain in the catalog and create its `CODEBASE.md` only if it has at least one Evidence entry or Fact; omit domains with no Evidence or Facts, even if they could have an overview.


## Writing rules

- **Classify every non-overview entry.** Evidence is supported by comments and unlabelled. A Fact is supplied by a maintainer, is inherently unverifiable in the repository, begins with the exact prefix `FACT:`, and is presumed true until a maintainer says it can be removed. The overview is neither Evidence nor Fact. Do not introduce another classification term.
- **Curate, don’t inventory.** Include only useful Evidence or Facts that help someone avoid a consequential mistake, understand surprising behavior, honor an important constraint, or perform a special test/release/operational task.
- **Keep the overview distinct.** It is an explicit exception to Evidence and Fact: include only a concise summary or orientation.
- **No comment citations.** Do not link to, quote, or attach source paths to comments supporting Evidence.
- **Describe consequences.** Prefer explaining why a code area is easy to break, what constraint matters, or what unusual action is required over stating an implementation detail without its significance.
- **Include incomplete work selectively.** A partial or incomplete implementation is Evidence only when comments support it; otherwise it can be included only if a maintainer supplies it as a Fact marked `FACT:`.
- **Do not include secrets.** Never copy unencrypted passwords, keys, tokens, credentials, or other secrets into the map.
- **Keep scope clear.** The document is not a technology/dependency/class listing, a complete architecture spec, or a place for content inferred only from code. Such content is neither Evidence nor a Fact.
