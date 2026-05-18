//
//  StartKitUITests.swift
//  StartKitUITests
//
//  Created by vfa on 14/5/26.
//

import XCTest

final class StartKitUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testExampleScreenDisplaysSeededExampleData() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.staticTexts["ExampleData"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["example.openDetail"].exists)
    }
}
