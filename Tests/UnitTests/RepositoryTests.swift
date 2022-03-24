import XCTest
import RxBlocking

@testable import NoodsRadio

class RepositoryTests: XCTestCase {

  var repository: NoodsRepository = Repository()

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

  func testShowDetailOnline() throws {
    let showDetail = try repository
      .showDetail(id: "shows/through-the-years-ethio-jazz-special-w-the-grey-area-20th-march-22")
      .debug()
      .toBlocking()
      .first()

    XCTAssertNotNil(showDetail)
    XCTAssertEqual(showDetail?.title, "Through The Years - Ethio Jazz special w/ The Grey Area")
  }

  func testShowDetailEmptyTracklist() throws {
    let showDetail = try repository
      .showDetail(id: "shows/rain-world-21st-march-22")
      .debug()
      .toBlocking()
      .first()

    XCTAssertNil(showDetail?.tracklist)
  }

  func testShowDetailOnline404() throws {
    let showDetail = repository
      .showDetail(id: "shows/through-the-years-ethio-jazz-special-w-the-grey-area-20th-march-21")
      .debug()
      .toBlocking()

    XCTAssertThrowsError(try showDetail.first())
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
