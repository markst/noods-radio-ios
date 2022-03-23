import RxSwift
import RxRelay

struct ShowsListViewModel {
  let repository: NoodsRepository
  let refresh = PublishRelay<Void>()

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
      .map({ $0.map(ShowViewModel.init) })
      .asObservable()
  }
}
