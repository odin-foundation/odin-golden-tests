# ODIN Golden Test Suite

The authoritative cross-language test suite for all ODIN SDK implementations. Every implementation (TypeScript, .NET, Java, Python, Ruby, Rust) must pass these tests with identical behavior.

**159 test files** covering parsing, serialization, canonicalization, schema validation, diffing, transforms, and end-to-end export.

## Purpose

Golden tests ensure cross-language parity:
- Same input produces identical output across all implementations
- Error codes and messages are consistent
- Edge cases are handled uniformly

## Directory Structure

```
golden/
├── parse/
│   ├── basic/              # Simple documents
│   ├── types/              # All type prefixes (#, ##, #$, ?, @, ^, ~)
│   ├── headers/            # Header context handling
│   ├── arrays/             # Array syntax and validation
│   ├── tabular/            # Tabular array syntax
│   ├── modifiers/          # !, *, - modifiers
│   ├── references/         # @path references
│   ├── multi-doc/          # --- document separator
│   └── errors/             # Error conditions (expected failures)
├── stringify/
│   ├── round-trip/         # parse(stringify(x)) == x
│   └── options/            # Pretty, comments, etc.
├── canonical/
│   ├── input/              # Source documents
│   └── expected/           # Byte-exact output
├── schema/
│   ├── parse/              # Schema parsing tests
│   └── definitions/        # Type definitions
├── validate/
│   ├── pass/               # Valid documents
│   ├── fail/               # Invalid documents with expected errors
│   ├── conditionals/       # :if field = value
│   ├── invariants/         # :invariant expressions
│   └── cardinality/        # :of constraints
├── diff/                   # Document comparison
└── patch/                  # Diff application
```

## Test File Format

Each `.json` test file contains:

```json
{
  "$schema": "https://odin.foundation/schemas/test-suite-v1.json",
  "suite": "parse-types",
  "description": "Tests for ODIN type prefixes",
  "tests": [
    {
      "id": "type-integer",
      "description": "Integer type prefix ##",
      "input": "count = ##42",
      "expected": {
        "assignments": {
          "count": { "type": "integer", "value": 42 }
        }
      }
    },
    {
      "id": "error-invalid-type-prefix",
      "description": "Invalid type prefix should error",
      "input": "value = ###42",
      "expectError": {
        "code": "P006",
        "message": "Invalid type prefix"
      }
    }
  ]
}
```

## Test Properties

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `id` | string | Unique identifier within suite |
| `description` | string | Human-readable description |
| `input` | string | ODIN text to parse |

### Expected Outcome (one required)

| Field | Type | Description |
|-------|------|-------------|
| `expected` | object | Expected parse result |
| `expectError` | object | Expected error code/message |

### Expected Result Structure

```json
{
  "expected": {
    "metadata": {
      "odin": "1.0.0"
    },
    "assignments": {
      "path.to.field": { "type": "string", "value": "..." }
    },
    "modifiers": {
      "path.to.field": { "critical": true }
    }
  }
}
```

### Expected Error Structure

```json
{
  "expectError": {
    "code": "P007",
    "message": "Duplicate path assignment",
    "line": 2,
    "column": 1
  }
}
```

## Integration

Add this repo as a git submodule in your SDK:

```bash
git submodule add https://github.com/odin-foundation/odin-golden-tests.git tests/golden
```

Or fetch in CI:

```bash
git clone --depth 1 https://github.com/odin-foundation/odin-golden-tests.git tests/golden
```

## Running Golden Tests

### TypeScript
```bash
npm run test:golden
```

### .NET
```bash
dotnet test --filter "Category=Golden"
```

### Java
```bash
mvn test -Dgroups=golden
```

### Python
```bash
pytest -m golden
```

### Ruby
```bash
bundle exec rspec --tag golden
```

### Rust
```bash
cargo test --test golden
```

## Adding New Tests

1. Create a `.json` file in the appropriate subdirectory
2. Follow the test file format above
3. Run tests in all implementations
4. Commit when all pass

## Canonical Output Verification

For canonical tests, use SHA-256 to verify byte-identical output:

```bash
# Generate canonical output from each implementation
ts-node scripts/canonical.ts input.odin | sha256sum
dotnet run canonical input.odin | sha256sum
java -jar odin.jar canonical input.odin | sha256sum
python -m odin canonical input.odin | sha256sum

# All hashes must match
```

## Error Code Reference

### Parse Errors (P001-P099)

| Code | Message |
|------|---------|
| P001 | Unexpected character |
| P002 | Invalid path segment |
| P003 | Invalid array index |
| P004 | Unterminated string |
| P005 | Invalid escape sequence |
| P006 | Invalid type prefix |
| P007 | Duplicate path assignment |
| P008 | Invalid header syntax |
| P009 | Invalid directive |
| P010 | Maximum depth exceeded |
| P011 | Maximum document size exceeded |
| P012 | Invalid UTF-8 sequence |
| P013 | Non-contiguous array indices |
| P014 | Empty document |
| P015 | Array index out of range |

### Validation Errors (V001-V099)

| Code | Message |
|------|---------|
| V001 | Required field missing |
| V002 | Type mismatch |
| V003 | Value out of bounds |
| V004 | Pattern mismatch |
| V005 | Invalid enum value |
| V006 | Array length violation |
| V007 | Unique constraint violation |
| V008 | Invariant violation |
| V009 | Cardinality constraint violation |
| V010 | Conditional requirement not met |
| V011 | Unknown field |
| V012 | Circular reference |
| V013 | Unresolved reference |
