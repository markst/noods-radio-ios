import XCTest
import RxBlocking

@testable import NoodsRadio

class RepositoryTests: XCTestCase {

  var repository: NoodsRepository = Repository()
  var mockRepository: NoodsRepository = MockRepository()

  override func setUpWithError() throws {

  }

  override func tearDownWithError() throws {

  }

  func testShowsOnline() throws {
    let shows = try repository
      .shows()
      .debug()
      .toBlocking()
      .toArray()

    XCTAssertNotNil(shows)
    XCTAssertTrue(shows.count > 0)
  }

  func testShowsMock() throws {
    let shows = try mockRepository
      .shows()
      .debug()
      .toBlocking()
      .toArray()

    XCTAssertNotNil(shows)

    XCTAssertEqual(shows[0].first?.id, "123")
    XCTAssertEqual(shows[0].first?.title, "Test")
  }

  func testShowDetailOnline() throws {
    let showDetail = try repository
      .showDetail(id: "shows/through-the-years-ethio-jazz-special-w-the-grey-area-20th-march-22")
      .debug()
      .toBlocking()
      .first()

    XCTAssertNotNil(showDetail)
    XCTAssertEqual(showDetail?.title, "Through The Years - Ethio Jazz special w/ The Grey Area")
  }

  func testShowDetailOnline404() throws {
    let showDetail = repository
      .showDetail(id: "shows/through-the-years-ethio-jazz-special-w-the-grey-area-20th-march-21")
      .debug()
      .toBlocking()

    XCTAssertThrowsError(try showDetail.first())
  }

  func testShowDetailMock() throws {
    let showDetail = try mockRepository
      .showDetail(id: "123")
      .debug()
      .toBlocking()
      .first()

    XCTAssertNotNil(showDetail)
    XCTAssertEqual(showDetail?.title, "123")
    XCTAssertNotEqual(showDetail?.title, "132")
  }

  func testShowsOnlinePerformance() throws {
    self.measure {
      try? testShowsOnline()
    }
  }

  func testShowDetailOnlinePerformance() throws {
    self.measure {
      try? testShowDetailOnline()
    }
  }
}
