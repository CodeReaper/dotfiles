# TERMINOLOGY.md Format


## Structure

```md
# {Domain Name}

{One or two sentence description of what this domain covers and why it exists.}

## Language

**Order**:
{A one or two sentence description of the term}
_Avoid_: Purchase, transaction

**Invoice**:
A request for payment sent to a customer after delivery.
_Avoid_: Bill, payment request

**Customer**:
A person or organization that places orders.
_Avoid_: Client, buyer, account

## Relationships

- An **Invoice** belongs to exactly one **Customer**
- An **Order** produces one or more **Invoices**

## Example dialogue

> **Dev:** "When a **Customer** places an **Order**, do we create the **Invoice** immediately?"
> **Domain expert:** "No — an **Invoice** is only generated once a **Fulfillment** is confirmed. A single **Order** can produce multiple **Invoices** if items ship in separate **Shipments**."
> **Dev:** "So if a **Shipment** is cancelled before dispatch, no **Invoice** exists for it?"
> **Domain expert:** "Exactly. The **Invoice** lifecycle is tied to the **Fulfillment**, not the **Order**."
```


## Rules

- **Be opinionated.** When multiple words exist for the same concept, pick the best one and list the others under `_Avoid_`.
- **Keep definitions tight.** One or two sentences max. Define what it IS, not what it does.
- **Only include terms specific to this project's context.** General programming concepts (timeouts, error types, utility patterns) don't belong even if the project uses them extensively. Before adding a term, ask: is this a concept unique to this context, or a general programming concept? Only the former belongs.
- **Group terms under subheadings** when natural clusters emerge. If all terms belong to a single cohesive area, a flat list is fine.


## Single vs multi-domain repos

**Single domain (most repos):** One `TERMINOLOGY.md` at the repo root.

**Multiple domains:** A `TERMINOLOGY-CATALOG.md` at the repo root links to each domain's `TERMINOLOGY.md`, describes the domains, and explains how they relate to each other:

```md
# Terminology Catalog

## Domains

- [Ordering](./src/ordering/TERMINOLOGY.md): receives and tracks customer orders
- [Billing](./src/billing/TERMINOLOGY.md): generates invoices and processes payments
- [Fulfillment](./src/fulfillment/TERMINOLOGY.md): manages warehouse picking and shipping

## Cross-domain relationships

- **Ordering → Fulfillment**: Ordering emits `OrderPlaced` events; Fulfillment consumes them to start picking
- **Fulfillment → Billing**: Fulfillment emits `ShipmentDispatched` events; Billing consumes them to generate invoices
- **Ordering ↔ Billing**: Shared types for `CustomerId` and `Money`
```

The skill infers which structure applies:

- If `TERMINOLOGY-CATALOG.md` exists, read it to find domains and their terminology files
- If only a root `TERMINOLOGY.md` exists, use it for the single domain
- If neither exists, create a root `TERMINOLOGY.md` lazily when the first term is resolved

When multiple domains exist, infer which one the current topic relates to. If unclear, ask. When adding a domain terminology file, add its link and description to `TERMINOLOGY-CATALOG.md`.
