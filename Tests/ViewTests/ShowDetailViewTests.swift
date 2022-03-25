import SnapshotTesting
import XCTest

@testable import NoodsRadio

class ShowDetailViewTests: XCTestCase {
  func testShowDetailViewMock() {
    assertSnapshot(
      matching: ShowDetailView()
        .size(375, 812)
        .do({ $0.show = ShowViewModel(show: ShowDetail.mock) }),
      as: .image
    )
  }

  func testShowDetailViewMockTwo() {
    assertSnapshot(
      matching: ShowDetailView()
        .size(375, 812)
        .do({ $0.show = ShowViewModel(show: Show.mock) }),
      as: .image
    )
  }
}
