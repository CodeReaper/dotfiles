---
name: code-style
description: Enforces code consistency. Load this skill for all code changes, implementations, bug fixes, refactoring, code reviews, and code generation.
license: MIT
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

Follow explicit user instructions and established project conventions first. Use the guidance below as defaults when neither settles the choice.

### The Core Principles

- Beautiful is better than ugly
- Explicit is better than implicit
- Simple is better than complex
- Complex is better than complicated
- Flat is better than nested
- Sparse is better than dense
- Readability counts
- Special cases are not special enough to break the rules
- Although practicality beats purity
- Errors should never pass silently
- Unless explicitly silenced
- In the face of ambiguity, refuse the temptation to guess
- There should be one - and preferably only one - obvious way to do it
- Although that way may not be obvious at first unless you're Dutch
- Now is better than never
- Although never is often better than right now
- If the implementation is hard to explain, it's a bad idea
- If the implementation is easy to explain, it may be a good idea

## Predictability

It is required that potential ambiguity is cleared up during planning phase by asking the user for clarification instead of making assumptions.

During the execution or build phase no changes should be made that are not part of the agreed upon plan.

## Readability

The code is not just meant to be run, but to be read and understood by developers. The code should be easy to read quickly and hard to misunderstand.

### Storytelling

Class names, method names, function names, variable names, all should help inform the reader what the code does by reading these names and having the story of the code be told.

Code tells a story vertically line by line through methods, where each variable contributes to the narrative of data flow. Names of both variables and methods should support this flow rather than using long descriptors.

### Naming Conventions

- Use descriptive, but minimal, self-documenting names
- Avoid redundantly named variables in local scopes, if there is a single service, it should be named `service` and not `apiService`
- Prefer single shortest word for variables; add second word ONLY for disambiguation within scope, if there are two clients call them `apiClient` and `idClient`
- Avoid abbreviations unless universally understood (id, db, url, api)
- In names that combine words and abbreviations, capitalize abbreviations like ordinary words: ApiService, HttpRequest, not APIService or HTTPRequest. Apply the project’s casing convention to the full name (for example, apiClient for a lower-camel-case variable)

```go
// Good
var totalPrice float64
var userCount int
var service *Service
var apiClient *Client
var idClient *Client
var urlRequest *Socket
var tcpRequest *Socket

// Bad
var tp float64
var uc int
var apiService *Service
var apiHttpClient *Client
var idHttpClient *Client
var uRLRequest *Socket
var tCPRequest *Socket
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

- Each function should have one clear responsibility
- Maximum recommended parameters: 3
- If more parameters are needed, use object pattern

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

Never use block comments unless explicitly required by the doc language.

#### How to Comment

- Explain the "why", not the "what" (code shows what)
- Write notes detailing non-obvious behavior
- Prefer no comments. When a comment is necessary, use the language’s documentation-comment syntax on the relevant declaration. Do not add inline or trailing comments; TODO: and FIXME: are exceptions to this rule

```go
// Bad:
func NewUser(name, email string) (*User, error) {
    if (len(name) == 0) { // check the name is not empty
        return nil, fmt.Errorf("could not create user with empty name") // return an error due to name being empty
    } // name is not empty from here on
    return &User{Name: name, Email: email}, nil // return created user and nil
}

// Good:

// NewUser returns either a pointer to a User or an error.
// The arguments given are validated before creating the user.
func NewUser(name, email string) (*User, error) {
    if (len(name) == 0) {
        return nil, fmt.Errorf("could not create user with empty name")
    }
    return &User{Name: name, Email: email}, nil
}
```

#### When to Comment

- Document public API contracts
- Otherwise prefer no comments. When a comment is necessary, use the language’s documentation-comment syntax on the relevant declaration
- Mark technical debt with TODO:
- Mark unfinished work that must not reach main with FIXME:

#### Avoid

- Commented-out code (delete it, use version control)
- Obvious comments ("// Increment counter")
- Excessive comments (code should be self-documenting)

### Error Handling

Wrap errors with context to propagate the original error:

Example code of part of an ordering service processing an order:

```go
user, err := userService.lookup(orderId)
if (err != nil) {
    return fmt.Errorf("unable to process order %s, user lookup failed: %w", orderId, err)
}
err = orderService.ship(orderId, user)
if (err != nil) {
    return fmt.Errorf("unable to ship order %s: %w", orderId, err)
}
```

Use typed errors when possible to collect debugging details:

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
