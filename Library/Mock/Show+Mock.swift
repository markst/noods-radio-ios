import Foundation

extension Show {
  internal static let mock: Show = .init(
    id: "123",
    title: "Test",
    date: DateFormatter.default.date(from: "25.03.22"),
    artworkSmall: URL(string: "https://www.panel.noodsradio.com/media/pages/shows/2022/03/fruit-machine-19th-march-22/86eb86139f-1647948155/fruit-machine-25x25.jpg")!,
    genreTags: [],
    mixcloud: "https://www.mixcloud.com/NoodsRadio/fruit-machine-19th-march-22/")
}
