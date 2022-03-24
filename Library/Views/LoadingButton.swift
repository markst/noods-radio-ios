import UIKitPlus

public class LoadingButton: UButton {

  var activityIndicator = ActivityIndicator()

  @UState var loading: Bool = false

  init() {
    super.init(frame: .zero)
    body {
      activityIndicator
        .hidesWhenStopped(true)
        .color(.white)
        .started($loading)
        .centerInSuperview(x: -4, y: 0)
    }

    $loading.listen { [weak self] in self?.setNeedsLayout() }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UIView

  public override func layoutSubviews() {
    super.layoutSubviews()
    // Forces `titleLabel` if activity is visible:
    titleLabel?.isHidden = activityIndicator
      .isAnimating
    titleLabel?.alpha = activityIndicator
      .isAnimating ? 0.0 : 1.0
    imageView?.isHidden = activityIndicator
      .isAnimating
    imageView?.alpha = activityIndicator
      .isAnimating ? 0.0 : 1.0
  }
}

