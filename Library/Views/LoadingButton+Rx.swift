import RxSwift
import RxCocoa

extension Reactive where Base: LoadingButton {
  /// Bindable sink for .`loading` UState.
  public var isAnimating: Binder<Bool> {
    return Binder(self.base) { button, loading in
      button.loading = loading
    }
  }
}
