import Foundation

extension Date {
  func form() -> String {
    DateFormatter.default.string(from: self)
  }
}
