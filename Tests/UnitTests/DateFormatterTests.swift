import XCTest

@testable import NoodsRadio

class DateFormatterTests: XCTestCase {
    func testDateFormatter() throws {
      let date = DateFormatter.default
        .date(from: "23.03.22")
      let dateString = DateFormatter.default
        .string(from: Date(timeIntervalSince1970: 1647993600))

      XCTAssertNotNil(dateString)
      XCTAssertNotNil(date)

      XCTAssertEqual(date, DateFormatter.default.date(from: dateString))
      XCTAssertEqual(DateFormatter.default.string(from: date!), dateString)
    }
}
