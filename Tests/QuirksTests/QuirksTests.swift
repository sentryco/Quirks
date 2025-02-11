import Foundation
import Testing
import Quirks
/**
 * v1
 */
@Test func example() async throws {
   let jsonData = try getQuirksJsonData()
   
   let domain = "google.com"
   // Example Usage
   do {
      let rules = try PasswordRule.parsePasswordRules(from: jsonData)
      if let domainRule = PasswordRule.rule(for: domain, in: rules) {
         if let recipe = PasswordRecipe.passwordRecipe(from: domainRule) {
            print("✅ Password Recipe for \(domain):")
            print("✅ Length: \(recipe.length)")
            print("✅ Character Type: \(recipe.characterType)")
            print("✅ Use Character: \(recipe.useCharacter)")
            print("✅ Use Number: \(recipe.useNumber)")
            print("✅ Use Symbol: \(recipe.useSymbol)")
         } else {
            print("🚫 Could not create a password recipe for \(domain).")
         }
      } else {
         print("🚫 No rules found for domain: \(domain)")
      }
   } catch {
      print("🚫 Failed to parse rules: \(error)")
   }
}
/**
 * v2
 */
@Test func exmaple2() async throws {
   // Load the JSON data from the URL
   let jsonData = try getQuirksJsonData()
   // Parse the JSON data into a dictionary
   let rulesDictionary = try PasswordRulesParser.parsePasswordRulesJSON(data: jsonData)
   
   // Get the password rule for a specific domain
   let domain: String = "google.com"
   if let passwordRule: PasswordRule2 = PasswordRulesParser.getPasswordRule(for: domain, from: rulesDictionary) {
      // Derive the PasswordRecipe from the PasswordRule
      let passwordRecipe: PasswordRecipe2 = PasswordRulesParser.derivePasswordRecipe(from: passwordRule)
      
      // Use the PasswordRecipe as needed
      print("✅ Password Recipe for \(domain):")
      print("✅ Length: \(passwordRecipe.length)")
      print("✅ Character Type: \(passwordRecipe.characterType)")
      print("✅ Use Character: \(passwordRecipe.useCharacter)")
      print("✅ Use Number: \(passwordRecipe.useNumber)")
      print("✅ Use Symbol: \(passwordRecipe.useSymbol)")
   } else {
      print("🚫 No password rule found for \(domain)")
   }
}
 
