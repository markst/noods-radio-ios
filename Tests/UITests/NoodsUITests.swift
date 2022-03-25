import XCTest

class NoodsUITests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testShowDetail() throws {
    let app = XCUIApplication()
    app.launchArguments = ["NoAnimations"]
    app.launch()
    
    let cell = app.collectionViews
      .children(matching: .cell)
      .element(boundBy: 0)
    
    XCTAssertTrue(cell
      .waitForExistence(timeout: 10)
    )
    
    cell.tap()
    sleep(1)
    
    let playButton = app
      .scrollViews
      .otherElements
      .buttons["noods play"] // TODO: Add `accessibilityIdentifier`.
    
    XCTAssertTrue(playButton
      .waitForExistence(timeout: 10)
    )
  }
  
  func testPlaybackMixcloudFlow() throws {
    let app = XCUIApplication()
    app.launchArguments = ["NoAnimations"]
    app.launch()
    
    let cell = app.collectionViews
      .children(matching: .cell)
      .element(boundBy: 0)
    
    XCTAssertTrue(cell
      .waitForExistence(timeout: 10)
    )
    
    cell.tap()
    sleep(1)
    
    let playButton = app
      .scrollViews
      .otherElements
      .buttons["noods play"] // TODO: Add `accessibilityIdentifier`.
    
    XCTAssertTrue(playButton
      .waitForExistence(timeout: 10)
    )
    
    sleep(1)
    playButton.tap()
    
    // Expect `Safari` view controller modal:
    /*
     XCTAssertTrue(app.otherElements["BrowserView"]
     .waitForExistence(timeout: 10)
     )
     */
    
    let mixCloudPlay = app
      .webViews
      .webViews
      .webViews
      .images["cloudcast image"]
    
    XCTAssertTrue(mixCloudPlay
      .waitForExistence(timeout: 10)
    )
    
    // Screenshot as UIImage
    let _ = app.windows
      .firstMatch
      .screenshot()
      .image
    
    // Check against baseline
    // assertSnapshot(matching: screenshot, as: .image)
  }
  
  func testLaunchPerformance() throws {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
      // This measures how long it takes to launch your application.
      measure(metrics: [XCTApplicationLaunchMetric()]) {
        XCUIApplication().launch()
      }
    }
  }
}
