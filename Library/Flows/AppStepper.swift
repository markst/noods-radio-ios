import RxFlow
import RxRelay
import RxSwift

class AppStepper: Stepper {

  let steps = PublishRelay<Step>()

  private let appServices: AppServices

  init(withServices services: AppServices) {
    self.appServices = services
  }

  var initialStep: Step {
    return AppStep.shows
  }

  /// callback used to emit steps once the FlowCoordinator is ready to listen to them to contribute to the Flow
  func readyToEmitSteps() {
    print(#function)
  }
}
