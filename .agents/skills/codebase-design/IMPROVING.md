# Improving a Codebase

Use this workflow when the user wants to find architectural friction or deepening opportunities across a codebase. This includes requests to **explore new seams** when the goal is to discover opportunities in the codebase. For the shared vocabulary and design principles, see [SKILL.md](SKILL.md).


## 1. Choose a scope

- If the user names a module, subsystem, or pain point, focus there.
- Otherwise, inspect recent changes to find areas that have been changing repeatedly. Start with those areas; widen the scope if the changes are scattered or no clear hotspot emerges.
- Use the repository's domain language where available. Look for existing documentation or other sources that explain the concepts and terminology; don't assume a particular filename or require a glossary to exist.


## 2. Explore for architectural friction

Explore the scoped code and note where its structure makes understanding, changing, or testing behavior difficult. Look for signs such as:

- Understanding one concept requires following many small modules.
- A module is shallow: its interface is nearly as complex as its implementation.
- Logic is split into pure functions for testing, while important behavior in how they are called remains hard to test or change locally.
- Tightly coupled modules leak details across their seams.
- Behavior is untested or difficult to test through the module's interface.

Treat these as clues, not rules. Apply the **deletion test** before recommending that modules be combined: would removing the suspected module make complexity disappear, or would it spread that complexity across its callers? Look for opportunities that improve locality, leverage, and testability without adding a seam for hypothetical variation.


## 3. Present candidates

Present a concise set of grounded candidates. For each, describe:

- **Location**: the relevant files or modules.
- **Friction**: what makes the current structure costly to understand, change, or test.
- **Deepening opportunity**: the broad change that could improve the structure, in plain language.
- **Expected benefit**: how it could improve locality, leverage, and testing.
- **Confidence**: how strongly the code supports the diagnosis.

Use the project's domain terms where known and the architecture vocabulary from [SKILL.md](SKILL.md). Keep recommendations tied to observed code and avoid proposing a detailed interface before the user chooses a candidate.

End by asking which candidate the user would like to explore. Once they choose, help design the module and its interface using [SKILL.md](SKILL.md). If they want to compare substantially different interface designs, use [DESIGN-IT-TWICE.md](DESIGN-IT-TWICE.md).
