import Foundation
/**
 * Ext + Decoder
 */
extension PasswordRule {
   /**
    * Custom decoding initializer for dynamic keys (if you need to decode directly)
    */
   public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
      guard let key = container.allKeys.first else {
         throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath,
                                                 debugDescription: "Expected at least one key"))
      }
      domain = key.stringValue
      let nested = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: key)
      minLength = try? nested.decode(Int.self, forKey: .minLength)
      maxLength = try? nested.decode(Int.self, forKey: .maxLength)
      required = try? nested.decode(String.self, forKey: .required)
      disallowed = try? nested.decode(String.self, forKey: .disallowed)
   }
}
