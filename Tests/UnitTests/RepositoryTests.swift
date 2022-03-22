import XCTest
import RxBlocking

@testable import NoodsRadio

class RepositoryTests: XCTestCase {

  var repository: NoodsRepository = Repository()

  override func setUpWithError() throws {

  }

  override func tearDownWithError() throws {

  }

  func testShows() throws {
    let shows = try repository
      .shows()
      .debug()
      .toBlocking()
      .toArray()

    XCTAssertNotNil(shows)
    XCTAssertTrue(shows.count > 0)
  }

  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
}
