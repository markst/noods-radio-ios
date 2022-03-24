import RxRelay
import RxSwift
import RxSwiftUtilities
import RxFlow
import Foundation

struct ShowDetailViewModel {

  let identity: String

  let repository: NoodsRepository
  let refresh = PublishRelay<Void>()
  let activityIndicator = ActivityIndicator()
  let steps = PublishRelay<Step>()

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

extension ShowDetailViewModel: Stepper {
  var initialStep: Step {
    return AppStep.show(withId: identity)
  }

  public func playShow(url: URL) {
    self.steps.accept(AppStep.play(url: url))
  }
}
