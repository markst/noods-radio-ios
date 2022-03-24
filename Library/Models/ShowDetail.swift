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
         descriptio = "description",
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

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    title = try values.decodeIfPresent(String.self, forKey: .title)
    slug = try values.decode(String.self, forKey: .slug)
    date = try values.decodeIfPresent(Date.self, forKey: .date)
    artistTag = try values.decodeIfPresent([String].self, forKey: .artistTag)
    descriptio = try? values.decodeIfPresent(Description.self, forKey: .descriptio)
    residentId = try values.decodeIfPresent(String.self, forKey: .residentId)
    genreTags = try values.decodeIfPresent([String].self, forKey: .genreTags)
    tracklist = try? values.decodeIfPresent(Description.self, forKey: .tracklist)
    guestmix = try values.decodeIfPresent(Bool.self, forKey: .guestmix)
    artworkSmall = try values.decodeIfPresent(String.self, forKey: .artworkSmall)
    mixcloud = try values.decodeIfPresent(String.self, forKey: .mixcloud)
    resident = try values.decodeIfPresent([Resident].self, forKey: .resident)
    showsByArtist = try values.decodeIfPresent([Show].self, forKey: .showsByArtist)
    similarShows = try values.decodeIfPresent([Show].self, forKey: .similarShows)
  }

  init(title: String?,
       slug: String,
       date: Date?,
       artistTag: [String],
       descriptio: Description?,
       residentId: String?,
       genreTags: [String],
       tracklist: Description?,
       guestmix: Bool?,
       artworkSmall: String?,
       mixcloud: String?,
       resident: [Resident],
       showsByArtist: [Show],
       similarShows: [Show]) {
    self.title = title
    self.slug = slug
    self.date = date
    self.artistTag = artistTag
    self.descriptio = descriptio
    self.residentId = residentId
    self.genreTags = genreTags
    self.tracklist = tracklist
    self.guestmix = guestmix
    self.artworkSmall = artworkSmall
    self.mixcloud = mixcloud
    self.resident = resident
    self.showsByArtist = showsByArtist
    self.similarShows = similarShows
  }
}
