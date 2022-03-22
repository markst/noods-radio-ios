import Foundation
import Moya
import RxMoya
import RxSwift

protocol NoodsRepository {
  func shows() -> Single<[Show]>
}

struct Repository {
  let provider: MoyaProvider<PanelApi>

  init(provider: MoyaProvider<PanelApi> = .init(plugins: [
    NetworkLoggerPlugin(configuration: .init(logOptions: .errorResponseBody))
  ])) {
    self.provider = provider
  }
}

extension Repository: NoodsRepository {
  func shows() -> Single<[Show]> {
    provider.rx
      .request(.shows)
      .filterSuccessfulStatusCodes()
      .map([Show].self,
           atKeyPath: "featured",
           using: JSONDecoder.default,
           failsOnEmptyData: false
      )
  }
}
