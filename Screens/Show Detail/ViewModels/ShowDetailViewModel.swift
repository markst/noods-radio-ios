import RxRelay
import RxSwift
import RxSwiftUtilities
import RxFlow
import Foundation

protocol ShowDetailProtocol: Stepper {
  var refresh: PublishRelay<Void> { get }
  var activityIndicator: ActivityIndicator { get }

  func showDetail() -> Observable<ShowViewModel>
  func playShow(url: URL)
  func cloudcast(with url: URL) throws -> Observable<MixCloudGraphResponse.MixCloudGraphData.Cloudcast?>
}

struct ShowDetailViewModel: ShowDetailProtocol {

  let refresh = PublishRelay<Void>()
  let activityIndicator = ActivityIndicator()
  let steps = PublishRelay<Step>()

  // MARK: - Privates
  private let repository: NoodsRepository
  private let identity: String

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

extension ShowDetailViewModel {
  var initialStep: Step {
    return AppStep.shows
  }

  public func playShow(url: URL) {
    self.steps.accept(AppStep.play(url: url))
  }
}
