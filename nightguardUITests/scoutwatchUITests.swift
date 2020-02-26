//
//  scoutwatchUITests.swift
//  scoutwatchUITests
//
//  Created by Dirk Hermanns on 20.11.15.
//  Copyright © 2015 private. All rights reserved.
//

import XCTest

class scoutwatchUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        addUIInterruptionMonitor(withDescription: "Accept disclaimer") { alert -> Bool in
            if alert.alerts["Disclaimer!"].exists {
                alert.alerts["Disclaimer!"].scrollViews.otherElements.buttons["Accept"].tap()
                return true
            }
            return false
        }

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        setupSnapshot(app)
        app.launchArguments.append("--uitesting")
        app.launchEnvironment["TEST"] = "1"
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTabsBars() {
        let tabBarsQuery = app.tabBars
        XCTAssertEqual(tabBarsQuery.buttons.count, 4)

        /**
         * Note! Used index to find localized buttons because accessibility identifier doesn't work with tabBars like
         * tabBarsQuery.buttons["prefs_button"].tap()
         * See https://forums.developer.apple.com/thread/64157
         */
        tabBarsQuery.buttons.element(boundBy: 3).tap()
        snapshot("01-preferences")

        tabBarsQuery.buttons.element(boundBy: 0).tap()
        snapshot("02-main")

        tabBarsQuery.buttons.element(boundBy: 1).tap()
        snapshot("03-alarms")

        tabBarsQuery.buttons.element(boundBy: 2).tap()
        snapshot("04-stats")
    }
    
}
