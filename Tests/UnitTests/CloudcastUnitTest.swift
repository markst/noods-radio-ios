import XCTest
import Moya

@testable import NoodsRadio

class CloudcastUnitTest: XCTestCase {
  func testCloudcastParse() throws {
    let viewModel: ShowDetailProtocol = ShowDetailViewModel(
      identity: "shows/through-the-years-ethio-jazz-special-w-the-grey-area-20th-march-22",
      repository: Repository(
        provider: .init(stubClosure: MoyaProvider.delayedStub(0.5))
      )
    )
    
    let showDetail = try viewModel
      .showDetail()
      .toBlocking()
      .toArray()
      .first

    let cloudcast = try viewModel
      .cloudcast(with: showDetail!.mixcloud!)
      .toBlocking()
      .single()

    XCTAssertNotNil(cloudcast?.streamInfo.hlsUrl)
    XCTAssertNotNil(cloudcast?.streamInfo.url)
    XCTAssertNotNil(cloudcast?.streamInfo.dashUrl)

    // Decrypt the stream url:
    let url = try [cloudcast?.streamInfo.hlsUrl,
                   cloudcast?.streamInfo.url,
                   cloudcast?.streamInfo.dashUrl]
      .map({ $0?.decrypt(with: .decryptionKey) })
      .first??
      .asURL()

    XCTAssertNotNil(url)
  }
}

extension String {
  static let decryptionKey = "IFYOUWANTTHEARTISTSTOGETPAIDDONOTDOWNLOADFROMMIXCLOUD"
}
