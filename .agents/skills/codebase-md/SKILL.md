---
name: codebase-md
description: Create, review, or update a project's CODEBASE.md or CODEBASE-CATALOG.md with a high-level map of risky areas, fragile behavior, integrations, hidden dependencies, and incomplete implementations. Use only when the user explicitly asks to work on these files.
---

# Codebase Map

Create and maintain a concise, evidence-led map of what is consequential or easy to misunderstand in this repository. This skill is **user-invoked only**: do not create, update, or suggest updating these files during unrelated work. The user decides when a map should be reviewed or refreshed.

The map is not a technology inventory, dependency list, class/module catalog, or a summary of obvious implications. Its Evidence and Facts cover only what materially affects understanding, testing, operating, releasing, or safely changing the codebase.

## Choose the file structure

Most repositories are one codebase and should have a root `CODEBASE.md`.

Use a root `CODEBASE-CATALOG.md` only when the repository has a clear multi-domain division. A repository is multi-domain when it has multiple cohesive areas with distinct responsibilities or workflows, and separate maps would make the codebase knowledge easier to navigate and maintain. Folders, packages, services, or deployment boundaries alone do not establish separate domains. If a concise repository overview can orient readers and the noteworthy knowledge naturally clusters into multiple domain-specific maps, use a catalog; otherwise use one root `CODEBASE.md`.

The catalog has its own concise overview of the whole codebase, links to domain-specific `CODEBASE.md` files only for domains that have at least one Evidence entry or Fact, and provides a dedicated section for genuine cross-domain concerns. A domain overview alone does not qualify a domain for a map file or catalog link. Keep the catalog and domain files concise and avoid duplicating the same Evidence or Facts across them.

```text
/
├── CODEBASE-CATALOG.md
├── ordering/
│   └── CODEBASE.md
└── billing/
    └── CODEBASE.md
```

Do not create a catalog merely because a repository has folders, services, or packages. If neither file exists, choose the structure based on the repository and create a document only when there is useful content to record, whether comment-supported or supplied by a maintainer. In a multi-domain repository, create a domain file and link to it from the catalog only when that domain has at least one Evidence entry or Fact. A domain overview alone is not enough. Do not create empty or boilerplate domain maps or links.

## The two terms

Every map entry outside the overview is classified as either **Evidence** or a **Fact**. Evidence is supported by comments and is unlabelled. A Fact is supplied by a maintainer, is inherently unverifiable in the repository, starts with `FACT:`, and is presumed true until a maintainer says it can be removed. These are the only two terms for classifying map entries.

Evidence must be supported by one or more comments in the repository. Do not link to or cite those comments. Evidence may synthesize several comments. You may read code to understand what a comment refers to, but the support must come from the comments themselves; code behavior, tests, configuration, and external documentation alone are not Evidence.

The overview is an explicit exception to the Evidence/Fact categories. It must be only a concise summary or orientation to the codebase, not a place for records. Do not link to or cite comments in the map.

During every update, present all Facts marked `FACT:` together in a separate numbered confirmation list. Do not add another marker.

Examples of useful content include:

- Code areas where a seemingly small change can have broad or surprising effects.
- Fragile behavior, footguns, or failure modes that require context to avoid.
- Important implicit dependencies or assumptions between parts of the system.
- Special external integrations and operational requirements, such as provider allowlists or manual coordination.
- Testing instructions that are unusual or necessary to exercise consequential behavior.
- Release, deployment, or migration steps that are special and relevant to maintainers.
- Partial or incomplete implementations, when comments support them as Evidence or a maintainer provides them as a Fact marked `FACT:`.

Do not include general technologies, dependency inventories, class or function inventories, content inferred only from code, or obvious implications. Do not record unencrypted sensitive information such as passwords, API keys, tokens, or secrets.

## Create or update workflow

Run this workflow only after the user explicitly requests creation, review, or update of the codebase map.

1. **Read the current map and repository guidance.** Inspect existing `CODEBASE.md` and `CODEBASE-CATALOG.md` files, relevant `AGENTS.md` instructions, and determine whether the repository is a single codebase or has a clear multi-domain division. Treat distinct cohesive responsibilities or workflows as evidence of domains only when separate maps would improve navigation and maintenance; folders, packages, services, or deployment boundaries alone are not enough.
2. **Search relevant documentation.** If the repository has an organized documentation directory, use a subagent to search it for relevant operational, integration, testing, and release details, then summarize its findings. Treat them as leads, not Evidence. Include them as Evidence only when comments support them.
3. **Identify the source technologies and file types.** Inspect representative source and supporting files, then determine which comment syntaxes apply. Include relevant scripts, tests, configuration, deployment, migration, and operational files when they can contain explanatory comments.
4. **Explicitly search for comments.** Use `grep` or `ripgrep` to search the relevant files for each applicable comment syntax and for markers such as `TODO`, `FIXME`, `stub`, `incomplete`, and `not implemented`. Determine comment syntax from the technologies and file types present; search broadly enough to catch ordinary explanatory comments, not only marked work items. Read files containing multiline comments in context; a search hit alone does not establish what the comment means.
5. **Understand candidate comments.** Read surrounding source only if needed to interpret a comment's subject and scope. Ensure each proposed piece of Evidence is actually stated or supported by comments. Do not treat behavior observed in source, tests, or documentation as Evidence without supporting comments.
6. **Revalidate existing Evidence.** Check it against comments discovered during the comment-search step. If supporting comments appear absent, investigate thoroughly: broaden the comment search across relevant source and supporting files, consider alternate terminology and locations, and read surrounding source only as needed to interpret comments. Source behavior may help locate or understand a comment but is not Evidence by itself. Absence of a search hit alone is not proof that Evidence is obsolete. If support still appears missing, include it in the approval list rather than removing it immediately.
7. **Prepare two separate review lists.** Before applying content changes, present these lists in order:
   1. All proposed changes to Evidence entries: additions, edits, and removals. Unchanged Evidence does not need approval.
   2. All Facts marked `FACT:`, asking the user to confirm each one. Every Fact must be presented for confirmation on every update.

   Keep the lists separate and complete them in order: finish the entire Evidence changes list before beginning the Fact confirmation list. For long lists, present numbered chunks grouped by area or domain, but do not interleave the lists. If either list is empty, say so explicitly. Wait for the user's decisions before applying Evidence changes or changing/removing Facts. A Fact remains presumed true unless a maintainer says it can be removed. If the user wants to retain Evidence whose comment support is gone, ask whether they want it reclassified as a Fact marked `FACT:`; do not silently reclassify it.

8. **Add and revise content.** Add only high-value Evidence supported by comments or Facts explicitly supplied by a maintainer and marked `FACT:`. Capture meaningful partial implementations and unusual test, release, or operational guidance only when it is either Evidence or a Fact.
9. **Keep the map selective.** Prefer concise Evidence or Facts that explain why an area is risky, surprising, constrained, or operationally important. Avoid implementation catalogs and low-value detail. Do not invent support or silently change Evidence into a Fact or a Fact into Evidence.

10. **Connect repository guidance.** If a root `AGENTS.md` exists and does not mention the codebase map, offer to add a relative link directing agents to consult it when planning or reviewing changes that may affect consequential or fragile code paths, integrations, or operational workflows. This helps those changes account for known risks and constraints. Keep this offer separate from the Evidence and Fact review lists, and do not edit `AGENTS.md` unless the user separately agrees.

    For one root map:

    ```md
    When planning or reviewing changes, consult the [CODEBASE.md](./CODEBASE.md) to account for known risks and constraints involving consequential or fragile code paths, integrations, and operational workflows. This map contains selective information; the absence of an entry does not imply an area is safe or unconstrained.
    ```

    For a catalog:

    ```md
    When planning or reviewing changes, consult the [CODEBASE-CATALOG.md](./CODEBASE-CATALOG.md) and follow its links to the relevant codebase map or maps to account for known risks and constraints involving consequential or fragile code paths, integrations, and operational workflows. These maps contain selective information; the absence of an entry does not imply an area is safe or unconstrained.
    ```

When no update is needed, say so rather than changing the document for its own sake. If a question cannot be resolved from comments or maintainer confirmation, preserve the existing content pending review and clearly describe the uncertainty.
