import Foundation
/**
 * - Note: must be in non test scope for bundle to work etc
 */
public func getQuirksJsonData() throws -> Data  {
   guard let url = Bundle.module.url(forResource: "password-rules", withExtension: "json") else {
      throw NSError(domain: "Failed to locate password-rules.json in the test bundle.", code: 0)
   }
   //   Swift.print("url: \(url)")
   // Load the JSON data from the URL
   let jsonData = try Data(contentsOf: url)
   return jsonData
}
