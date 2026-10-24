---
name: code-testing
description: Checks behavior is tested in the right module, coverage is meaningful, and tests are not unnecessarily duplicated. Use when adding, changing, reviewing, or removing tests.
---

Build the smallest clear, reliable test suite that covers required application behavior and important failure modes. Optimize for confidence, clear failure diagnostics, and maintenance cost — not the fewest test functions or the highest coverage percentage.

## Test behavior in the module that owns it

- Identify the behavior, the module that owns it, and the regression each test should detect.
- Cover detailed decisions and edge cases in tests for the responsible module, preferably through its interface.
- Follow the established test organization in the project. Do not require a one-to-one mapping between implementation files and test files.
- When testing a caller, cover its decisions, outcomes, and meaningful interactions. Do not duplicate detailed tests of dependency behavior. Check dependency effects when they establish required behavior at the caller interface.
- Use other modules to arrange fixtures when useful. Prefer testing the behavior of each module in its own tests.

## Test application behavior, not dependency guarantees

- Do not independently prove behavior already guaranteed by the language, operating system, framework, or library.
- Do test how the application uses those guarantees: configuration, translation, error handling, resource ownership, and recovery.
- Choose real dependencies or test doubles according to the behavior being verified. Ensure that doubles preserve relevant dependency behavior. Do not replace a real interaction with a double when the test is intended to verify that interaction.
- Assert internal calls, counts, or ordering only when they express a real requirement, such as avoiding duplicate requests or ensuring cleanup — not incidental implementation choices.

## Separate module-level detail from integration checks

- Use integration tests to verify that real modules connect correctly and produce the intended externally observable behavior.
- Retain a representative successful workflow across important seams.
- Add integration failure cases when the risk lies in the interaction: error translation, transactions, cancellation, persistence, or cleanup.
- Do not repeat the full decision matrix of a module at every integration layer. Repeat a case only when it protects a distinct interaction risk.

## Avoid redundant coverage

For each test, consider:

1. What plausible regression would this detect?
2. Which module is responsible for that behavior?
3. What distinct requirement, failure mode, interaction check, useful diagnostic signal, or regression protection would be lost if this test were removed? Is equivalent coverage available elsewhere?

Prefer focused cases and representative combinations over testing every possible combination, unless the combinations materially change behavior.

Do not remove a test merely because it executes the same code as another. Executing the same code does not mean the tests protect against the same regressions.

## Keep tests trustworthy

- Control clocks, randomness, and external state where practical.
- Prefer observable results over private implementation details.
- Keep assertions strong enough to reject plausible incorrect behavior.
- Do not merge unrelated cases merely to reduce test count.
- Establish expected behavior from contract examples, independently derived results, or meaningful properties. Avoid circular assertions and copies of the decision logic under test.

## Workflow

Honor the requested scope and use clear conversational context to resolve ambiguities. If cleanup scope remains unclear, ask before expanding to the whole project. Inspect related implementation and tests as needed without expanding the scope of changes.

When reviewing tests, assess the current changes by default, including tests added, updated, or removed and behavior changes that require coverage. Report findings without modifying files.

When cleaning up tests, assess tests within the established scope and preserve application behavior and existing requirements. Report suspected implementation bugs or unclear requirements separately. Do not weaken assertions just to make tests pass.

1. Read relevant implementation, requirements, and existing tests to understand the behavior under test. Do not judge what the tests protect from diffs alone.
2. Map important behaviors and failure modes to responsible modules and existing protection.
3. Identify missing coverage, misplaced assertions, duplicated matrices, and appropriate local or integration cases.
4. Before cleanup, run the relevant suite when execution is available to establish a baseline. For bug fixes, verify when practical that the regression test fails against faulty behavior and passes after the fix.
5. When writing or cleaning up tests, make the requested changes and explain the protection retained after any consolidation or removal.
6. Run relevant tests after modifications when possible. Report pre-existing failures, verification results, assumptions, and checks not performed.

Use coverage metrics as supporting evidence, not as proof of behavioral coverage.
