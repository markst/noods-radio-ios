import UIKitPlus

class AppDelegate: BaseApp {
  @AppBuilder override var body: AppBuilderContent {
    Lifecycle.didFinishLaunching {
      
    }.willResignActive {
      
    }.willEnterForeground {
      
    }
    MainScene { .main }
    .mainScreen {
      NavigationController(
        UIViewController()
          .background(.red))
        .style(.transparent)
        .hideNavigationBar()
    }
    
  }
}
