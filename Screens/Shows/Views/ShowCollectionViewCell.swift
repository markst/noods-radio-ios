import UIKitPlus

class ShowCollectionViewCell: UCollectionCell {
  
  @UState var viewModel: ShowViewModel?
  
  override func buildView() {
    super.buildView()
    
    contentView.body {
      UVStack {
        UImage(url: $viewModel.map({ $0?.image }))
          .background(.gray)
          .aspectRatio()
          .mode(.scaleAspectFill)
          .corners(4, [])
          .masksToBounds()
        UText($viewModel.map({ $0?.title ?? "" }))
          .font(.helveticaNeueRegular, 12)
          .multiline()
          .alignment(.left)
          .color(0x000000)
        UText($viewModel.map({ $0?.date ?? "" }))
          .font(.helveticaNeueRegular, 10)
          .lines(1)
          .alignment(.left)
          .color(0x828282)
        UCollection(LeftAlignedCollectionViewFlowLayout()
                      .estimatedItemSize(18, 18)
                      .scrollDirection(.vertical)
                      .minimumLineSpacing(4)
                      .minimumInteritemSpacing(4)
                      .sectionInset(0)) {
          UForEach($viewModel.map({ $0?.genres ?? [] })) {
            GenreTagCell($0)
          }
        }.background(.white)
          .height(>=60)
      }
      .spacing(8)
      .edgesToSuperview()
    }
  }
}

#if canImport(SwiftUI)

import SwiftUI

extension ShowCollectionViewCell: Then { }

@available(iOS 13.0, *)
struct MessageMyView_Preview: PreviewProvider, DeclarativePreview {
  static var preview: Preview {
    Preview {
      ShowCollectionViewCell(frame: .init(
        origin: .zero,
        size: .init(width: 200, height: 335)))
        .background(.white)
        .do({ $0.viewModel = ShowViewModel.mock })
          }
    .colorScheme(.light)
    .layout(.fixed(width: 200, height: 335))
    .language(.en)
  }
}

#endif
