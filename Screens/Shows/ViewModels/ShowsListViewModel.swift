import RxSwift
import RxRelay
import RxSwiftUtilities

struct ShowsListViewModel {
  let repository: NoodsRepository
  let refresh = PublishRelay<Void>()
  let activityIndicator = ActivityIndicator()

  lazy var dataSource: Observable<[ShowViewModel]> = {
    refresh
      .asObservable()
      .startWith(())
      .flatMap { [self] in self.shows() }
      .share()
  }()

  // MARK: - Init

  init(repository: NoodsRepository = Repository()) {
    self.repository = repository
  }

  // MARK: - Functions

  func shows() -> Observable<[ShowViewModel]> {
    repository
      .shows()
      .trackActivity(activityIndicator)
      .map({ $0.map(ShowViewModel.init) })
      .asObservable()
  }
}
