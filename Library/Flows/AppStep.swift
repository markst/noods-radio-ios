import RxFlow

enum AppStep: Step {
  case shows
  case show(withId: String)
  case player
}
