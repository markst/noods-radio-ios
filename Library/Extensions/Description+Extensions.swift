import Atributika
import Foundation.NSAttributedString

extension Description {
  /// Converts HTML string to a `NSAttributedString`
  var attributedString: NSAttributedString? {
    return html?
      .style(tags: Style("p"))
      .attributedString
  }
}
