
//
//  CMBTeamUITests.swift
//  CMBTeamUITests
//
//  Created by Buwaneka Galpoththawela on 2/8/17.
//  Copyright © 2017 Buwaneka Galpoththawela. All rights reserved.
//

import XCTest

class CMBTeamUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        
        
        let app = XCUIApplication()
        
        XCTAssertEqual(app.collectionViews.count, 1)
        
       let collectionView = app.collectionViews.element(boundBy: 0)
        XCTAssertEqual(collectionView.cells.count, 6)
        
        
        app.collectionViews.cells.containing(.staticText, identifier:"Sherrie Chen").children(matching: .image).element.tap()
        app.otherElements.containing(.navigationBar, identifier:"Sherrie Chen").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element.swipeUp()
        app.navigationBars["Sherrie Chen"].buttons["Meet The Team"].tap()
        
        
    }
    
}
