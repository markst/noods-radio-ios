import Foundation

extension JSONDecoder {
  static var `default`:JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted({
      let df = DateFormatter()
      df.dateFormat = "dd.MM.yyyy"
      df.timeZone = .init(identifier: "UTC")
      return df
    }())

    return decoder
  }
}
