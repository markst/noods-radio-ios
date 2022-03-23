import RxSwift
import RxRelay
import RxSwiftUtilities
import RxFlow

struct ShowsListViewModel {
  let repository: NoodsRepository
  let refresh = PublishRelay<Void>()
  let activityIndicator = ActivityIndicator()
  let steps = PublishRelay<Step>()
  
  lazy var dataSource: Observable<[ShowViewModel]> = {
    refresh
      .asObservable()
      .startWith(())
      .flatMap { [self] in self.shows() }
      .share()
  }()
  
  // MARK: - Init
  
  init(repository: NoodsRepository) {
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

extension ShowsListViewModel: Stepper {
  var initialStep: Step {
    return AppStep.shows
  }
  
  public func pick(showId: String) {
    self.steps.accept(AppStep.show(withId: showId))
  }
}
