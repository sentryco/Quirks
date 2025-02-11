# Quirks

Adher to domain password quirks

## Features

1. Parse the password-rules.json into an array of items (struct) that matches its schema
2. For domain. return struct
3. Derive PasswordRecipe from that struct

## Examples

```swift
let jsonData = try! getQuirksJsonData()
let domain = "google.com"
let rules = try! PasswordRule.parsePasswordRules(from: jsonData)
if let domainRule! = PasswordRule.rule(for: domain, in: rules)
if let recipe! = PasswordRecipe.passwordRecipe(from: domainRule)
print("\(recipe.length)") // 16
print("\(recipe.characterType)") // mixed
print("\(recipe.useCharacter)") // false
print("\(recipe.useNumber)") // false
print("\(recipe.useSymbol)") // false
```

**JSON:**

```json
{
    "example.com": {
        "min-length": 8,
        "max-length": 64,
        "required": "lower, upper, digit",
        "disallowed": "symbol"
    },
    "anotherdomain.com": {
        "min-length": 10,
        "max-length": 32,
        "required": "lower, digit, symbol",
        "disallowed": "upper"
    }
}
```

### Installation:

`.package(url: "https://github.com/sentryco/Quirks/", branch: "main")`

### Resources: 

- Here is the password-rules.json: https://github.com/apple/password-manager-resources/blob/main/quirks/password-rules.json
- For inspo a javascript interpreter can be found here: https://github.com/apple/password-manager-resources/blob/main/tools/PasswordRulesParser.js
