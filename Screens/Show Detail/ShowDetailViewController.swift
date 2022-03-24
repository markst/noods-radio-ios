import UIKitPlus
import RxSwift

class ShowDetailViewController: ViewController {

  enum ShowDetailError: Error {
    case failedRequest
  }

  // MARK: - Init

  required init(viewModel: ShowDetailViewModel) {
    self.detailView.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    print(#file, #function)
  }

  // MARK: - View Setup

  internal let detailView = ShowDetailView()
  internal let disposeBag = DisposeBag()

  override func buildUI() {
    super.buildUI()

    onViewWillAppear { [weak self] /*animated*/ in
      self?.detailView.viewModel?.refresh.accept(())
      self?.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    body {
      detailView
        .edgesToSuperview(
          top: .init(wrappedValue: 0),
          leading: .init(wrappedValue: 0),
          trailing: .init(wrappedValue: 0),
          bottom: .init(wrappedValue: 0),
          safeArea: true
        )
    }

    bindView()
  }
  

  func bindView() {
    // Bind detail request:
    detailView.viewModel?.refresh
      .flatMap { [unowned self] in
        detailView.viewModel?.showDetail() ??
          .error(ShowDetailError.failedRequest)
      }
      .observe(on: MainScheduler.asyncInstance)
      .subscribe(
        onNext: { [weak detailView] show in
          detailView?.show = show
        },
        onError: { [weak detailView]  error in
          print("Error: \(error)")
          detailView?.display(error)
        })
      .disposed(by: disposeBag)
    // Bind refresh control:
    detailView.viewModel?.activityIndicator
      .asObservable()
      .observe(on: MainScheduler.asyncInstance)
      .bind(to: detailView.refreshControl.rx.isRefreshing)
      .disposed(by: disposeBag)
  }
}
