import UIKitPlus
import RxFlow

class AppDelegate: BaseApp {

  let appServices = AppServices(repository: Repository())
  var coordinator = FlowCoordinator()

  @AppBuilder override var body: AppBuilderContent {
    Lifecycle
      .didFinishLaunching { [unowned self] in
        // Avoid loading `ShowsListViewController` is rendering previews:
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
          return
        }
        // Launch app flow:
        let appFlow = AppFlow(withServices: self.appServices)

        self.coordinator.coordinate(flow: appFlow, with: AppStepper(withServices: self.appServices))

        Flows.use(appFlow, when: .created) { root in
          mainScene
            .mainScreen({ root })
            .switch(to: .main, animation: .fade)
        }
      }
      .willResignActive {
        
      }
      .willEnterForeground {
        
      }

    MainScene { .splash }
    .splashScreen {
      // Return animated splash:
      UIViewController()
    }
  }
}
