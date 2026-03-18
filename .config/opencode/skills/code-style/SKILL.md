---
name: code-style
description: Enforce consistent code across all generated code. Use when writing new code, refactoring, or reviewing code changes.
license: MIT
compatibility: opencode
metadata:
  audience: all-developers
  workflow: code-generation
---

## The Basics

All languages have best practices, ways of working, formatting rules and language-specific idioms. Always adhere to these ideals of the current language unless configured or directly asked to ignore them.

Seek out formatting and style configuration files relevant to the current language:

- All languages: .editorconfig
- Go: gofmt, golangci-lint config
- Swift: .swiftlint
- C#: StyleCop
- Python: pyproject.toml, .flake8, ruff.toml
- TypeScript/JavaScript: .prettierrc, eslint config
- Rust: rustfmt.toml

You will fallback to mimicking the code style of the other code files in the current repository.

Code examples are given as Golang, but should be applied as translated to the current language.

### The Core Principles

- Beautiful is better than ugly.
- Explicit is better than implicit.
- Simple is better than complex.
- Complex is better than complicated.
- Flat is better than nested.
- Sparse is better than dense.
- Readability counts.
- Special cases are not special enough to break the rules.
- Although practicality beats purity.
- Errors should never pass silently.
- Unless explicitly silenced.
- In the face of ambiguity, refuse the temptation to guess.
- There should be one - and preferably only one - obvious way to do it.
- Although that way may not be obvious at first unless you're Dutch.
- Now is better than never.
- Although never is often better than right now.
- If the implementation is hard to explain, it's a bad idea.
- If the implementation is easy to explain, it may be a good idea.
- Namespaces are one honking great idea – let's do more of those!

### Purpose

It is required that potential ambiguity is cleared up by asking the human for clarification instead of making assumptions.

## Readability

The code is not just meant to be run, but to be read and understood by human developers. The code should be easy to read quickly and hard to misunderstand.

### Storytelling

Class names, method names, function names, variable names, all should help inform the reader of the code what the code does by reading these names and having the story of the code be told.

### Naming Conventions

- Use descriptive, but minimal, self-documenting names
- Avoid redundantly named variables in local scopes, if there is a single service, it should be named `service` and not `apiService`
- Avoid abbreviations unless universally understood (id, db, url, api)
- Words combined with abbreviations means the abbreviation should only be capitalized (ApiService, HttpRequest)

```go
// Good
var totalPrice float64
var userCount int
var service *Service

// Bad
var tp float64
var uc int
var apiService *Service
```

### Lines

When you need to split a line over multiple lines, each argument must be on its own line.

Attempt to group logically related lines with a blank line between groups.

```go
result := calculate(
    firstArgument,
    secondArgument,
    thirdArgument,
)

resp, err := send(result)
```

### Files

There is no minimum or maximum number of lines in a file.

There should only be one public type definition per file. There is no limit for supporting private types in the same file.

### Single Responsibility

- Each function should do one thing well
- Maximum recommended parameters: 3
- If more needed, use object pattern

```go
// Bad - too many parameters
func NewUser(name, email, role, department, manager string) (*User, error) {}

// Good - options struct
type UserOptions struct {
    Role       string
    Department string
    Manager    string
}

func NewUser(name, email string, opts UserOptions) (*User, error) {}
```

### Comments

It is important to never use multi-line comments, unless explicitly required by doc language.

#### When to Comment

- Explain "why", not "what" (code shows what)
- Document public API contracts
- Note non-obvious behavior
- Mark technical debt with TODO:
- Use FIXME: markers for items to resolve before merging to main

#### Avoid

- Commented-out code (delete it, use version control)
- Obvious comments ("// Increment counter")
- Excessive comments (code should be self-documenting)

### Error Handling

- Use typed errors when possible
- Wrap errors with context using `fmt.Errorf("operation: %w", err)`

```go
type NotFoundError struct {
    Resource string
    ID       string
    Err      error
}
func (e *NotFoundError) Error() string {
    return fmt.Sprintf("%s not found: %s", e.Resource, e.ID)
}
func (e *NotFoundError) Unwrap() error {
    return e.Err
}
// Usage
if user == nil {
    return nil, &NotFoundError{Resource: "user", ID: id, Err: err}
}
```

### Constants

- Do not use hardcoded values, use constants instead
- Group related constants in a block

```go
const (
    MaxRetries  = 3
    Timeout     = 30 * time.Second
    DefaultPort = 8080
)
```

### Braces

- There are no optional braces - they are always required

```go
// Valid, but avoid - no braces
if (err != nil) return nil, err

// Good - braces present
if (err != nil) {
    return nil, err
}
```
