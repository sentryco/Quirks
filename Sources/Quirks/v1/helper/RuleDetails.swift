import Foundation
/**
 * Helper struct for inner rule details.
 */
struct RuleDetails: Codable {
   let minLength: Int?
   let maxLength: Int?
   let required: String?
   let disallowed: String?
}
/**
 * Ext + CodingKeys
 */
extension RuleDetails {
   /**
    * CodingKeys
    */
   enum CodingKeys: String, CodingKey {
      case minLength = "min-length"
      case maxLength = "max-length"
      case required
      case disallowed
   }
}
