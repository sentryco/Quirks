import Foundation

extension PasswordRule {
   /**
    * Decode the top-level JSON into an array of PasswordRule.
    */
   public static func parsePasswordRules(from jsonData: Data) throws -> [PasswordRule] {
      let decoder = JSONDecoder()
      // Decode into a dictionary [domain: RuleDetails]
      let rawRules = try decoder.decode([String: RuleDetails].self, from: jsonData)
      // Map each dictionary element to a PasswordRule, setting the domain.
      let rules = rawRules.map { (domain, details) in
         PasswordRule(domain: domain,
                      minLength: details.minLength,
                      maxLength: details.maxLength,
                      required: details.required,
                      disallowed: details.disallowed)
      }
      return rules
   }
   /**
    * Retrieve the Rule for a Specific Domain
    */
   public static func rule(for domain: String, in rules: [PasswordRule]) -> PasswordRule? {
      return rules.first { $0.domain == domain }
   }
}
