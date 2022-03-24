import Foundation

struct ShowDetail : Codable {
  let title: String?
  let slug: String
  let date: Date?
  let artistTag: [String]?
  let descriptio: Description?
  let residentId: String?
  let genreTags: [String]?
  let tracklist: Description?
  let guestmix: Bool?
  let artworkSmall: String?
  let mixcloud: String?
  let resident: [Resident]?
  let showsByArtist: [Show]?
  let similarShows: [Show]?

  private enum CodingKeys : String, CodingKey {
    case title,
         slug,
         date,
         artistTag = "artisttag",
         descriptio,
         residentId,
         genreTags = "genretags",
         tracklist,
         guestmix,
         artworkSmall = "artworkSm",
         mixcloud,
         resident,
         showsByArtist = "showsbyartist",
         similarShows = "similarshows"
  }
}
