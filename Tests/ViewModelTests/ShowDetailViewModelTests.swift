import XCTest
import RxBlocking
import Moya

@testable import NoodsRadio

class ShowDetailViewModelTests: XCTestCase {
  
  func testShowDetailViewModelSuccessOne() throws {
    try testShowDetailViewModel(with: "shows/rain-world-21st-march-22")
  }
  
  func testShowDetailViewModelSuccessTwo() throws {
    try testShowDetailViewModel(with: "shows/through-the-years-ethio-jazz-special-w-the-grey-area-20th-march-22")
  }
  
  func testShowDetailViewModelFailureOne() throws {
    XCTAssertThrowsError(try testShowDetailViewModel(with: "shows/through-the-years-ethio-jazz-special-w-the-grey-area-20th-march-21"))
  }
  
  func testShowDetailViewModel(with id: String) throws {
    let viewModel: ShowDetailProtocol = ShowDetailViewModel(
      identity: id,
      repository: Repository(
        provider: .init(stubClosure: MoyaProvider.delayedStub(0.5))
      )
    )
    
    let showDetail = try viewModel
      .showDetail()
      .toBlocking()
      .toArray()
      .first
    
    let sampleResponse = try JSONDecoder.default
      .decode(ShowDetail.self, from: PanelApi.show(id: id).sampleData)
    
    XCTAssertNotNil(showDetail)
    XCTAssertEqual(showDetail, ShowViewModel.init(show: sampleResponse))
  }
}
