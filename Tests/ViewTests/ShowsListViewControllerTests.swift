import SnapshotTesting
import XCTest
import Moya

@testable import NoodsRadio

class ShowsListViewControllerTests: XCTestCase {
  func testShowsListViewController() {
    assertSnapshot(matching: ShowsListViewController(
      viewModel: .init(repository: Repository(
        provider: .init(
          stubClosure: MoyaProvider.immediatelyStub)
      ))
    ), as: .image)
  }

  func testShowsListViewControllerError() {
    assertSnapshot(matching: ShowsListViewController(
      viewModel: .init(repository: Repository(
        provider: .init(
          endpointClosure: errorEndpointClosure(),
          stubClosure: MoyaProvider.immediatelyStub
        )
      ))
    ), as: .image)
  }

  // MARK: Utils

  func errorEndpointClosure() -> (PanelApi) -> Endpoint {
    return { (target: PanelApi) -> Endpoint in
      return Endpoint(
        url: URL(target: target).absoluteString,
        sampleResponseClosure: { .networkError(ShowsListViewControllerTests.unitError) },
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers
      )
    }
  }

  static var unitError: NSError {
    NSError(
      domain: Bundle.main.bundleIdentifier!,
      code: 0,
      userInfo: [NSLocalizedDescriptionKey: "Unit Test Error" ]
    )
  }
}
