import RxDataSources
import Foundation

struct ShowViewModel: Equatable, IdentifiableType {
  let identity: String
  let title: String
  let image: URL?
  let date: String
  let genres: [String]

  init(show: Show) {
    self.identity = show.id
    self.title = show.title
    self.date = show.date.form()
    self.image = show.artworkSmall
    self.genres = show.genreTags.map({ $0.uppercased() })
  }
}
