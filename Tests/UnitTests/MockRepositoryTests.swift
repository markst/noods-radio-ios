import XCTest
import RxBlocking

@testable import NoodsRadio

class MockRepositoryTests: XCTestCase {

  var repository: NoodsRepository = MockRepository()

  override func setUpWithError() throws {

  }

  override func tearDownWithError() throws {

  }

  func testShowsMock() throws {
    let shows = try repository
      .shows()
      .debug()
      .toBlocking()
      .toArray()

    XCTAssertNotNil(shows)

    XCTAssertEqual(shows[0].first?.id, "123")
    XCTAssertEqual(shows[0].first?.title, "Test")
  }

  func testShowDetailMock() throws {
    let showDetail = try repository
      .showDetail(id: "123")
      .debug()
      .toBlocking()
      .first()

    XCTAssertNotNil(showDetail)
    XCTAssertEqual(showDetail?.title, "Join The Future: A History of Bassline - Part 2 (2005-2022)")
    XCTAssertNotEqual(showDetail?.title, "132")
  }
}
