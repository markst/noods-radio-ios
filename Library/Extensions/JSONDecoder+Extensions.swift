import Foundation

extension JSONDecoder {
  static var `default`:JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted({
      return DateFormatter.default
    }())
    return decoder
  }
}
