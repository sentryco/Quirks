import Foundation
/**
 * Define Structs Matching the JSON Schema
 */
public struct PasswordRule: Codable {
   public let domain: String
   public let minLength: Int?
   public let maxLength: Int?
   public let required: String?
   public let disallowed: String?
   /**
    * Explicit initializer for manual creation.
    */
   public init(domain: String, minLength: Int?, maxLength: Int?, required: String?, disallowed: String?) {
      self.domain = domain
      self.minLength = minLength
      self.maxLength = maxLength
      self.required = required
      self.disallowed = disallowed
   }
}



