import Foundation
/**
 * Represents a password rule item from the JSON
 */
public struct PasswordRulesItem2: Codable {
   let passwordRules: String
}
/**
 * CodingKeys ext
 */
extension PasswordRulesItem2 {
   /**
    * CodingKeys
    */
   public enum CodingKeys: String, CodingKey {
      case passwordRules = "password-rules"
   }
}
/**
 * Represents character classes in password rules
 */
public enum PasswordCharacterClass2: String {
   case upper
   case lower
   case digit
   case special
   case nonAscii = "non-ascii"
   // Add other cases if needed
}
/**
 * Represents the parsed password rule for a domain
 */
public struct PasswordRule2 {
   public let minLength: Int?
   public let maxLength: Int?
   public let required: [PasswordCharacterClass2]
   public let allowed: [PasswordCharacterClass2]
   public let maxConsecutive: Int?
}
/**
 * Represents a password recipe derived from a password rule
 */
public struct PasswordRecipe2 {
   public let length: Int // same as max-allowed-length
   public let characterType: CharacterType2
   public let useCharacter: Bool
   public let useNumber: Bool
   public let useSymbol: Bool
}
/**
 * CharacterType2
 */
public enum CharacterType2 {
   case lower
   case upper
   case mixed
}
/**
 * PasswordRulesParser
 */
public class PasswordRulesParser {
   /**
    * Parses the password-rules.json data into a dictionary
    * - Parameter data: The JSON data to parse
    * - Returns: A dictionary mapping domains to their password rules
    */
   public static func parsePasswordRulesJSON(data: Data) throws -> [String: PasswordRulesItem2] {
      let decoder = JSONDecoder()
      let passwordRulesDictionary = try decoder.decode([String: PasswordRulesItem2].self, from: data)
      return passwordRulesDictionary
   }
   
   /**
    * Retrieves the password rule for a given domain
    * - Parameters:
    *   - domain: The domain to retrieve the password rule for
    *   - rules: The dictionary of password rules
    * - Returns: The password rule for the domain, if it exists
    */
   public static func getPasswordRule(for domain: String, from rules: [String: PasswordRulesItem2]) -> PasswordRule2? {
      guard let item = rules[domain] else {
         return nil
      }
      return parsePasswordRuleString(item.passwordRules)
   }
   
   /**
    * Parses the password rules string into a PasswordRule struct
    * - Parameter ruleString: The password rules string to parse
    * - Returns: A PasswordRule struct containing the parsed information
    */
   public static func parsePasswordRuleString(_ ruleString: String) -> PasswordRule2 {
      var minLength: Int?
      var maxLength: Int?
      var required: [PasswordCharacterClass2] = []
      var allowed: [PasswordCharacterClass2] = []
      var maxConsecutive: Int?
      
      // Split the rules by semicolon
      let rules = ruleString.components(separatedBy: ";")
      for rule in rules {
         let trimmedRule = rule.trimmingCharacters(in: .whitespacesAndNewlines)
         if trimmedRule.isEmpty { continue }
         
         if trimmedRule.hasPrefix("minlength:") {
            if let value = parseIntValue(from: trimmedRule, prefix: "minlength:") {
               minLength = value
            }
         } else if trimmedRule.hasPrefix("maxlength:") {
            if let value = parseIntValue(from: trimmedRule, prefix: "maxlength:") {
               maxLength = value
            }
         } else if trimmedRule.hasPrefix("required:") {
            let classes = parseCharacterClasses(from: trimmedRule, prefix: "required:")
            required.append(contentsOf: classes)
         } else if trimmedRule.hasPrefix("allowed:") {
            let classes = parseCharacterClasses(from: trimmedRule, prefix: "allowed:")
            allowed.append(contentsOf: classes)
         } else if trimmedRule.hasPrefix("max-consecutive:") {
            if let value = parseIntValue(from: trimmedRule, prefix: "max-consecutive:") {
               maxConsecutive = value
            }
         }
      }
      
      return PasswordRule2(
         minLength: minLength,
         maxLength: maxLength,
         required: required,
         allowed: allowed,
         maxConsecutive: maxConsecutive
      )
   }
   
   /**
    * Helper to parse integer values from a rule string
    * - Parameters:
    *   - rule: The rule string to parse
    *   - prefix: The prefix to remove before parsing
    * - Returns: The integer value, if it exists
    */
   public static func parseIntValue(from rule: String, prefix: String) -> Int? {
      let valueString = rule.dropFirst(prefix.count).trimmingCharacters(in: .whitespacesAndNewlines)
      return Int(valueString)
   }
   
   /**
    * Helper to parse character classes from a rule string
    * - Parameters:
    *   - rule: The rule string to parse
    *   - prefix: The prefix to remove before parsing
    * - Returns: An array of PasswordCharacterClass
    */
   public static func parseCharacterClasses(from rule: String, prefix: String) -> [PasswordCharacterClass2] {
      let classesString = rule.dropFirst(prefix.count).trimmingCharacters(in: .whitespacesAndNewlines)
      let classNames = classesString.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
      var classes: [PasswordCharacterClass2] = []
      for name in classNames {
         if let characterClass = PasswordCharacterClass2(rawValue: name) {
            classes.append(characterClass)
         }
      }
      return classes
   }
   
   /**
    * Derives a PasswordRecipe from a PasswordRule
    * - Parameter rule: The PasswordRule to derive from
    * - Returns: A PasswordRecipe
    */
   public static func derivePasswordRecipe(from rule: PasswordRule2) -> PasswordRecipe2 {
      let length = rule.maxLength ?? 16 // Default length if not specified
      
      // Determine character types
      var characterType: CharacterType2 = .mixed
      if rule.required.contains(.upper) && !rule.required.contains(.lower) {
         characterType = .upper
      } else if rule.required.contains(.lower) && !rule.required.contains(.upper) {
         characterType = .lower
      }
      
      // Determine character usage
      let useCharacter = rule.required.contains(.upper) || rule.required.contains(.lower)
      let useNumber = rule.required.contains(.digit)
      let useSymbol = rule.required.contains(.special)
      
      return PasswordRecipe2(
         length: length,
         characterType: characterType,
         useCharacter: useCharacter,
         useNumber: useNumber,
         useSymbol: useSymbol
      )
   }
}
