import XCTest
import Moya
import Alamofire

@testable import NoodsRadio

class CloudcastUnitTest: XCTestCase {
  func testCloudcastParse() async throws {
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
    let urls = try [cloudcast?.streamInfo.hlsUrl,
                    cloudcast?.streamInfo.url,
                    cloudcast?.streamInfo.dashUrl]
      .map({ $0?.decrypt(with: .decryptionKey) })
      .map({ try $0?.asURL() })

    XCTAssertTrue(urls.compactMap({ $0 }).count > 0 )

    // Use `CollectionConcurrencyKit` for `asyncMap`?

    // Test the stream has valid response:
    let dataTask = await AF
      .request(urls[0]!, method: .head)
      .validate(statusCode: 200..<300)
      .serializingData()
      .response

    XCTAssertNil(dataTask.error)
  }
}

extension String {
  static let decryptionKey = "IFYOUWANTTHEARTISTSTOGETPAIDDONOTDOWNLOADFROMMIXCLOUD"
}
