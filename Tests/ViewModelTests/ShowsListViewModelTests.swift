import XCTest
import RxBlocking
import Moya

@testable import NoodsRadio

class ShowsListViewModelTests: XCTestCase {
  func testShowsListViewModelShows() throws {
    let viewModel = ShowsListViewModel(repository: Repository(
      provider: .init(stubClosure: MoyaProvider.delayedStub(0.5))
    ))

    let shows = try viewModel
      .shows()
      .toBlocking()
      .toArray()
      .first

    XCTAssertNotNil(shows)

    let sampleResponse = try JSONDecoder.default
      .decode([Show].self, from: PanelApi.shows.sampleData, keyPath: "featured")
      .map(ShowViewModel.init)

    XCTAssertEqual(shows, sampleResponse)
  }
}
