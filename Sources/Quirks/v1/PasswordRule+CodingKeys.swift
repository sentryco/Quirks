import Foundation
/**
 * Ext + CodingKeys
 */
extension PasswordRule {
   /**
    * CodingKeys
    */
   public enum CodingKeys: String, CodingKey {
      case minLength = "min-length"
      case maxLength = "max-length"
      case required
      case disallowed
   }
}
