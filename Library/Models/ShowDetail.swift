import Foundation

struct ShowDetail : Codable {
  let title: String?
  let slug: String?
  let ogimage: String?
  let ogDescription: String?
  let date: String?
  let artistTag: [String]?
  let description: Description?
  let residentId: String?
  let genretag: [String]?
  let genretags: [String]?
  let tracklist: Description?
  let guestmix: Bool?
  let srcset: String?
  let artworkSmall: String?
  let mixcloud: String?
  let resident: [Resident]?
  let showsByArtist: [Show]?
  let similarShows: [Show]?
  
  private enum CodingKeys : String, CodingKey {
    case title,
         slug,
         ogimage,
         ogDescription = "ogdescription",
         date,
         artistTag = "artisttag",
         description,
         residentId,
         genretag,
         genretags,
         tracklist,
         guestmix,
         srcset,
         artworkSmall = "artworkSm",
         mixcloud,
         resident,
         showsByArtist = "showsbyartist",
         similarShows = "similarshows"
  }
}
