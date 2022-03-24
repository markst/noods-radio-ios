import RxFlow
import Foundation

enum AppStep: Step {
  case shows
  case show(withId: String)
  case play(url: URL)
}
