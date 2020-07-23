//
//  ToDoListUITests.swift
//  ToDoListUITests
//
//  Created by Никита Плахин on 7/23/20.
//  Copyright © 2020 Никита Плахин. All rights reserved.
//

import XCTest

class ToDoListUITests: XCTestCase {

    var app:XCUIApplication! = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test1CreationTask() throws {
        let taskTitle = "UI test task title"
        
        let app = XCUIApplication()
        
        let previousNumberOfRows = app.tables.cells.count
        
        let addButton = app.navigationBars["mainNavigationBar"].buttons["addButton"]
        XCTAssertTrue(addButton.exists)
        addButton.tap()
        
        let creationView = app.otherElements["creationView"]
        XCTAssertTrue(creationView.exists)
        
        let creationTitleTextField = app.textFields["creationTitleTextField"]
        XCTAssertTrue(creationTitleTextField.exists)
        creationTitleTextField.tap()
        creationTitleTextField.typeText(taskTitle)
        
        let creationDatePicker = app.datePickers["creationDeadlineDatePicker"]
        XCTAssertTrue(creationDatePicker.exists)

        let saveButton = app.buttons["creationSaveButton"]
        XCTAssertTrue(saveButton.exists)
        saveButton.tap()
        
        let testTaskCell = app.tables.staticTexts[taskTitle]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: testTaskCell, handler: nil)
        waitForExpectations(timeout: 2, handler: nil)
        
        let currentNumberOfRows = app.tables.cells.count
        
        XCTAssertTrue(previousNumberOfRows + 1 == currentNumberOfRows)
                
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func test2ShowDescription() {
        let taskTitle = "UI test task title"
        
        let app = XCUIApplication()
        
        let testTaskCell = app.tables.staticTexts[taskTitle]
        XCTAssertTrue(testTaskCell.exists)
        
        testTaskCell.tap()
        let descriptionView = app.otherElements["descriptionView"]
        XCTAssertTrue(descriptionView.exists)
        
        let descriptionTitleLabel = descriptionView.staticTexts["descriptionTitleLabel"]
        XCTAssertTrue(descriptionTitleLabel.exists)
        let descriptionDeadlineLabel = descriptionView.staticTexts["descriptionDeadlineLabel"]
        XCTAssertTrue(descriptionDeadlineLabel.exists)
        let descriptionRemainingTimeLabel = descriptionView.staticTexts["descriptionRemainingTimeLabel"]
        XCTAssertTrue(descriptionRemainingTimeLabel.exists)
        
        descriptionView.swipeDown()
        XCTAssertFalse(descriptionView.exists)
    }
    
    func test3DeletionTask() {
        let taskTitle = "UI test task title"
        
        let app = XCUIApplication()
        
        let previousNumberOfRows = app.tables.cells.count
        
        let testTaskCell = app.tables.staticTexts[taskTitle]
        XCTAssertTrue(testTaskCell.exists)
        testTaskCell.swipeLeft()
        testTaskCell.swipeLeft()
        
        let currentNumberOfRows = app.tables.cells.count
        
        XCTAssertTrue(previousNumberOfRows - 1 == currentNumberOfRows)
        
        XCTAssertFalse(testTaskCell.exists)
    }
}
