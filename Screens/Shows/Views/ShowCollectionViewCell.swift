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
          .compressionResistance(y: .required)
          .mode(.scaleAspectFill)
          .corners(4, [])
          .masksToBounds()
        UText($viewModel.map({ $0?.title ?? "" }))
          .font(.hkGroteskBold, 18)
          .multiline()
          .alignment(.left)
          .color(0x000000)
          .compressionResistance(y: .required)
        UText($viewModel.map({ $0?.date ?? "" }))
          .font(.hkGroteskSemiBold, 14)
          .lines(1)
          .alignment(.left)
          .color(0x828282)
          .compressionResistance(y: .required)
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
          .compressionResistance(y: .required)
          .height(>=60)
      }
      .spacing(8)
      .edgesToSuperview()
    }
  }

  override var isHighlighted: Bool {
    didSet {
      contentView.alpha = isHighlighted ? 0.5 : 1.0
    }
  }
  
  // MARK: - UICollectionReusableView

  override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    let attr = super.preferredLayoutAttributesFitting(layoutAttributes)

    let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
    let autoLayoutSize = contentView.systemLayoutSizeFitting(
      targetSize,
      withHorizontalFittingPriority: .required,
      verticalFittingPriority: .fittingSizeLevel)

    attr.frame = .init(origin: attr.frame.origin, size: autoLayoutSize)
    return attr
  }
}

#if canImport(SwiftUI)

import SwiftUI

extension ShowCollectionViewCell: Then { }

@available(iOS 13.0, *)
struct ShowCollectionViewCell_Preview: PreviewProvider, DeclarativePreview {
  static var preview: Preview {
    Preview {
      ShowCollectionViewCell(frame: .init(
        origin: .zero,
        size: .init(width: 300, height: 500)))
        .background(.white)
        .do({ $0.viewModel = ShowViewModel.mock })
    }
    .colorScheme(.light)
    .layout(.fixed(width: 300, height: 500))
    .language(.en)
  }
}

#endif
