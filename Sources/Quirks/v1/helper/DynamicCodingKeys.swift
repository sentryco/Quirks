import Foundation
/**
 * Helper type for dynamic keys.
 */
struct DynamicCodingKeys: CodingKey {
   var stringValue: String
   var intValue: Int? { return nil }
   
   init?(stringValue: String) { self.stringValue = stringValue }
   init?(intValue: Int) { return nil }
}
