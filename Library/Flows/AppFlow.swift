import RxFlow
import RxRelay
import RxSwift
import SafariServices
import UIKit.UINavigationController
import UIKitPlus

class AppFlow: Flow {
  var root: Presentable {
    return self.rootViewController
  }

  private let services: AppServices
  private let rootViewController = NavigationController()
    .style(.color(.white))
    .tint(.black)
    .hideNavigationBar()
    .statusBarStyle(.light)

  init(withServices services: AppServices) {
    self.services = services
  }

  func navigate(to step: Step) -> FlowContributors {
    switch step as? AppStep {
    case .shows:
      return navigateToShowList()
    case .show(let id):
      return navigateToShowDetail(with: id)
    case .play(let url):
      return navigateToMixCloudPlayer(with: url)
    default:
      return .none
    }
  }

  private func navigateToShowList() -> FlowContributors {
    let viewController = ShowsListViewController(
      viewModel: ShowsListViewModel(repository: services.repository)
    )
    rootViewController.pushViewController(viewController, animated: true)

    return .one(flowContributor: .contribute(
      withNextPresentable: viewController,
      withNextStepper: viewController.viewModel)
    )
  }

  private func navigateToShowDetail(with id: String) -> FlowContributors {
    let viewController = ShowDetailViewController(
      viewModel: .init(identity: id, repository: services.repository)
    )
    rootViewController.pushViewController(viewController, animated: true)

    return .one(flowContributor: .contribute(
      withNextPresentable: viewController,
      withNextStepper: viewController.detailView.viewModel!)
    )
  }

  private func navigateToMixCloudPlayer(with url: URL) -> FlowContributors {
    let safariViewController = SFSafariViewController(
      url: url
    )
    safariViewController.modalPresentationStyle = .formSheet
    rootViewController.present(
      safariViewController,
      animated: true,
      completion: nil
    )
    return .none
  }
}
