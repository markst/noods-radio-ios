import Foundation
import RxSwift
import RxDataSources
import UIKitPlus

class ShowsListViewController: ViewController {

    override var statusBarStyle: StatusBarStyle { .dark }

    var viewModel: ShowsListViewModel
    let disposeBag = DisposeBag()

    // MARK: - Init

    required init(viewModel: ShowsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print(#file, #function)
    }

    // MARK: -

    @UState var cellSize: CGSize = .init(width: 320, height: .max)

    lazy var collectionView = UCollectionView(
        UCollectionViewFlowLayout()
            .itemSize(UICollectionViewFlowLayout.automaticSize)
            .estimatedItemSize(cellSize)
            .scrollDirection(.vertical)
            .sectionInset(40))
        .register(ShowCollectionViewCell.self)
        .refreshControl(URefreshControl().onRefresh { [unowned self] in
            viewModel.refresh.accept(())
        })
        .edgesToSuperview()
        .background(.clear)

    override func buildUI() {
        super.buildUI()

        title = "Shows"

        onViewDidLayoutSubviews { [unowned self] in
            cellSize = .init(width: view.frame.width - 80, height: 1000)
            // Update `estimatedItemSize` directly:
            (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?
                .estimatedItemSize = cellSize
        }
        body {
            collectionView
                .background(.white)
                .topToSuperview(0, safeArea: true)
                .edgesToSuperview(leading: 0, trailing: 0, bottom: 0)
        }
        bindView()
    }

    func bindView() {
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<String, ShowViewModel>>(
            animationConfiguration: .init(insertAnimation: .automatic, reloadAnimation: .none, deleteAnimation: .automatic),
            configureCell: { (model, view, indexPath, item) -> UICollectionViewCell in
                let cell = view.dequeueReusableCell(
                    withReuseIdentifier: ShowCollectionViewCell.reuseIdentifier,
                    for: indexPath) as! ShowCollectionViewCell
                cell.viewModel = item
                return cell
            })

        disposeBag.insert(
            viewModel
                .dataSource
                .map({ [ AnimatableSectionModel<String, ShowViewModel>(
                    model: "Show",
                    items: $0
                )] })
                .asObservable()
                .bind(to: collectionView.rx.items(dataSource: dataSource)),
            collectionView.rx
                .modelSelected(ShowViewModel.self)
                .delay(.milliseconds(120), scheduler: MainScheduler.asyncInstance)
                .bind { [unowned self] item in
                    viewModel.pick(showId: item.identity)
                })
        disposeBag.insert(
            viewModel.activityIndicator
                .asDriver()
                .drive(collectionView.refreshControl!.rx.isRefreshing)
        )
    }
}


#if canImport(SwiftUI)

import SwiftUI

extension ShowsListViewController {
    static var mock: ShowsListViewController {
        let vc = ShowsListViewController(
            viewModel: .init(repository: MockRepository())
        )
        return vc
    }
}


@available(iOS 13.0, *)
struct DiffableCollectionViewController_Preview: PreviewProvider, DeclarativePreview {
    static var preview: Preview {
        Preview {
            ShowsListViewController.mock
        }
        .colorScheme(.light)
        .device(.iPhoneX)
        .language(.en)
    }
}

#endif
