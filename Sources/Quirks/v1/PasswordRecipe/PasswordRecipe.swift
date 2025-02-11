import Foundation
/**
 * PasswordRecipe - Derive PasswordRecipe from PasswordRule
 */
public struct PasswordRecipe {
   public let length: Int         // same as max-allowed-length from JSON
   public let characterType: CharacterType
   public let useCharacter: Bool
   public let useNumber: Bool
   public let useSymbol: Bool
}
