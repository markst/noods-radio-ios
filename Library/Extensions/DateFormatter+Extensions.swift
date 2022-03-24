import Foundation

extension DateFormatter {
  static var `default`:DateFormatter {
    let df = DateFormatter()
    df.dateFormat = "dd.MM.yy"
    df.timeZone = .init(identifier: "UTC")
    return df
  }
}
