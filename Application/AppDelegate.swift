import UIKitPlus

class AppDelegate: BaseApp {
  
  @AppBuilder override var body: AppBuilderContent {
    Lifecycle
      .didFinishLaunching {
        
      }
      .willResignActive {
        
      }
      .willEnterForeground {
        
      }
    
    MainScene { .main }
    .mainScreen {
      // Avoid loading `ShowsListViewController` is rendering previews:
      if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
        return UIViewController()
      }
      return NavigationController(ShowsListViewController(viewModel: ShowsListViewModel()))
        .style(.transparent)
        .hideNavigationBar()
    }
  }
}
