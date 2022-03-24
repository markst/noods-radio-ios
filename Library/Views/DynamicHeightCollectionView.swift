import UIKit.UICollectionView

class DynamicHeightCollectionView: UICollectionView {
  override func layoutSubviews() {
    super.layoutSubviews()
    if bounds.size != intrinsicContentSize {
      self.invalidateIntrinsicContentSize()
    }
  }

  override var intrinsicContentSize: CGSize {
    return collectionViewLayout.collectionViewContentSize
  }
}
