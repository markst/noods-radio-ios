import Foundation

struct Show: Codable {
  let id: String
  let title: String
  let date: Date?
  let artworkSmall: URL
  let genreTags: [String]
  let mixcloud: String
  
  private enum CodingKeys : String, CodingKey {
    case id,
         title,
         date,
         artworkSmall = "artworkSm",
         genreTags = "genretag",
         mixcloud
  }
}
