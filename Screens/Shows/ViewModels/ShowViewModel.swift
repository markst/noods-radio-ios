import RxDataSources
import Foundation

protocol ShowCellOutput { // ViewModelPressible
  var title: String { get }
  var image: URL? { get }
  var date: String { get }
  var genres: [String] { get }
}

protocol ShowDetailViewOutput: ShowCellOutput {
  var descriptio: NSAttributedString? { get }
  var tracklist: NSAttributedString? { get }
  var mixcloud: URL? { get }
}

extension ShowViewModel: ShowCellOutput & ShowDetailViewOutput { }

struct ShowViewModel: Equatable, IdentifiableType {
  let identity: String
  let title: String
  let image: URL?
  let date: String
  let genres: [String]

  // Show detail:
  let descriptio: NSAttributedString?
  let tracklist: NSAttributedString?
  let mixcloud: URL?

  // MARK: - Init

  init(show: Show) {
    self.identity = show.id
    self.title = show.title
    self.date = show.date?.form() ?? ""
    self.image = show.artworkSmall
    self.genres = show.genreTags.map({ $0.uppercased() })

    self.descriptio = nil
    self.tracklist = nil
    self.mixcloud = nil
  }

  init(show: ShowDetail) {
    self.identity = show.slug
    self.title = show.title ?? ""
    self.date = show.date?.form() ?? ""
    self.image = try? show.artworkSmall?.asURL()
    self.genres = show.genreTags?.map({ $0.uppercased() }) ?? []

    self.descriptio = show.descriptio?.attributedString ?? .init(string: "")
    self.tracklist = show.tracklist?.attributedString ?? .init(string: "")
    self.mixcloud = try? show.mixcloud?.asURL()
  }
}
