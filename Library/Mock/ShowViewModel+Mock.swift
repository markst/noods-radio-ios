import Foundation

extension ShowViewModel {
  static let mock: ShowViewModel = .init(
    identity: "al-jourgensen-special",
    title: "Al Jourgensen Special w/ Heads on Sticks",
    date: DateFormatter.default.date(from: "25.03.22"),
    genres: ["HARDCORE PUNK", "EBM", "THRASH", "INDUSTRIAL"]
  )
  
  init(identity: String, title: String, date: Date?, genres: [String]) {
    self.identity = identity
    self.title = title
    self.date = date?.form() ?? ""
    self.image = nil
    self.genres = genres
    self.descriptio = nil
    self.tracklist = nil
    self.mixcloud = nil
  }
}
