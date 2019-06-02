//
//  SearchEventViewControllerTests.swift
//  AssignmentExpediaTests
//
//  Created by Saalis Umer on 6/1/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import XCTest
@testable import AssignmentExpedia
class SearchEventViewControllerTests: XCTestCase {
    var searchEventViewController: SearchEventViewController?
    override func setUp() {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchEventViewController")
        self.searchEventViewController = vc as? SearchEventViewController
    }

    override func tearDown() {
        self.searchEventViewController = nil
    }

    func testIfViewControllerExistsWithIdentifier() {
        XCTAssertNotNil(self.searchEventViewController)
    }
    
    func testIfViewControllerContainsSarchBarAndSearchCancelButton()
    {
        if let vc = self.searchEventViewController
        {
            let _ = vc.view
            XCTAssertNotNil(vc.searchBar)
            XCTAssertNotNil(vc.searchButton)
            XCTAssertNotNil(vc.searchBackground)
            XCTAssertNotNil(vc.widthOfSearchBar)
            XCTAssertNotNil(vc.tableView)
        }
    }
    
    func testCorrectWidthOfSearchBarIsUpdated()
    {
        if let vc = self.searchEventViewController
        {
            let _ = vc.view
            vc.updateWidthOfSearchBar(width: 100, animation: false)
            XCTAssertEqual(vc.widthOfSearchBar.constant, 100)
        }
    }
    
    func testCorrectWidthOfSearchBarIsUpdatedWithAnimation()
    {
        if let vc = self.searchEventViewController
        {
            let _ = vc.view
            vc.updateWidthOfSearchBar(width: 300, animation: true)
            XCTAssertEqual(vc.widthOfSearchBar.constant, 300)
        }
    }
    
    func testGetWidthOfSearchBarNonEditing()
    {
        if let vc = self.searchEventViewController
        {
            let _ = vc.view
            let width = vc.getWidthOfSearchBar(isEditing: false, screenWidth: 200, padding: 10, cancelSearchWidth: 30)
            XCTAssertEqual(width, 180)
        }
    }
    
    func testGetWidthOfSearchBarEditing()
    {
        if let vc = self.searchEventViewController
        {
            let _ = vc.view
            let width = vc.getWidthOfSearchBar(isEditing: true, screenWidth: 200, padding: 10, cancelSearchWidth: 30)
            XCTAssertEqual(width, 140)
        }
    }
    
    func testTableViewDatasourceAndDelegateInitializedOnViewLoad()
    {
        if let vc = self.searchEventViewController
        {
            let _ = vc.view
            XCTAssertNotNil(vc.eventTableViewDatasource)
            XCTAssertNotNil(vc.eventTableViewDelegate)
        }
    }
    
    func testDatasource()
    {
        if let vc = self.searchEventViewController
        {
            let _ = vc.view
            vc.setEventAPIClient(client: MockAPIClient())
            let expectation = self.expectation(description: "Number of Rows should be 3")
            
            vc.makeAPICallFor(keyword: "google", pageNumber: 1) {
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 1) { (err) in
            }
            
            XCTAssertEqual(vc.eventTableViewDatasource?.tableView(vc.tableView, numberOfRowsInSection: 0    ), 3)
        }
    }
}
