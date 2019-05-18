//
//  MyNewsAppUITests.swift
//  MyNewsAppUITests
//
//  Created by Ashish Tripathi on 11/5/19.
//  Copyright © 2019 Ashish Tripathi. All rights reserved.
//

import XCTest
@testable import MyNewsApp

class MyNewsAppUITests: XCTestCase {

    var newsApp: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        newsApp = XCUIApplication()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        newsApp = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testNewsDetailsScreen() {
        newsApp.launch()
        newsApp.tables["newsTableViewIdentifier"].cells["NewsCell_1520130938"].staticTexts["newsBodyIdentifier"].tap()
    }
    
    func testTableInteraction() {
        newsApp.launch()
        let newsTable =  newsApp.tables.matching(identifier: "newsTableViewIdentifier")
        XCTAssertNotNil(newsTable)
    }
    
    func testTableViewDetail() {
        newsApp.launch()
        newsApp.navigationBars["News"].buttons["Refresh"].tap()
    }
}
