import RxRelay
import RxSwift
import RxSwiftUtilities

struct ShowDetailViewModel {

  let identity: String

  let repository: NoodsRepository
  let refresh = PublishRelay<Void>()
  let activityIndicator = ActivityIndicator()

  // MARK: - Init

  init(identity: String, repository: NoodsRepository) {
    self.identity = identity
    self.repository = repository
  }

  // MARK: - Functions

  func showDetail() -> Observable<ShowViewModel> {
    repository
      .showDetail(id: identity)
      .trackActivity(activityIndicator)
      .map(ShowViewModel.init)
  }
}
