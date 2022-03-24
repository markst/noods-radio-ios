import RxFlow
import Foundation

enum AppStep: Step {
  case shows
  case show(ShowViewModel)
  case play(url: URL)
}
