import SnapshotTesting
import XCTest
import Moya
import UIKitPlus

@testable import NoodsRadio


class ShowsListViewControllerTests: XCTestCase {
  func testShowsListViewController() {
    let vc = ShowsListViewController(
      viewModel: .init(repository: Repository(
        provider: .init(
          stubClosure: MoyaProvider.immediatelyStub)
      ))
    )

    // XCUIDevice.shared.orientation = .portrait

    vc.view.widthAnchor
      .constraint(equalToConstant: 375)
      .isActive = true
    vc.view.heightAnchor
      .constraint(equalToConstant: 812)
      .isActive = true

    assertSnapshot(matching: vc, as: .image)
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
