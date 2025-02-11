import Foundation

extension PasswordRecipe {
   /**
    * passwordRecipe
    * - Fixme: ⚠️️ add error types
    */
   public static func passwordRecipe(from rule: PasswordRule) -> PasswordRecipe? {
//      guard
         let maxLength = rule.maxLength ?? 16 // Default length if not specified
//      else { Swift.print("no maxLength"); return nil }
      
      let requiredComponents = rule.required?
         .components(separatedBy: ",")
         .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() } ?? []
      
      let useCharacter = requiredComponents.contains { $0 == "lower" || $0 == "upper" }
      let useNumber = requiredComponents.contains { $0 == "digit" || $0 == "number" }
      let useSymbol = requiredComponents.contains("symbol")
      
      let hasLower = requiredComponents.contains("lower")
      let hasUpper = requiredComponents.contains("upper")
      let characterType: CharacterType
      if hasLower && !hasUpper {
         characterType = .lower
      } else if hasUpper && !hasLower {
         characterType = .upper
      } else if hasLower && hasUpper {
         characterType = .mixed
      } else {
         characterType = .mixed
      }
      
      return PasswordRecipe(length: maxLength,
                            characterType: characterType,
                            useCharacter: useCharacter,
                            useNumber: useNumber,
                            useSymbol: useSymbol)
   }
}
