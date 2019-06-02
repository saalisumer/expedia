//
//  SearchResultMetaTest.swift
//  AssignmentExpediaTests
//
//  Created by Saalis Umer on 5/27/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import XCTest
@testable import AssignmentExpedia
class SearchResultMetaTest: XCTestCase {
    var searchResultMetaJSON:[String:Int]?
    override func setUp() {
        self.searchResultMetaJSON = ["per_page":10,"total":100,"page":1]
    }

    override func tearDown() {
        self.searchResultMetaJSON = nil
    }
    
    func testSearchResultMetaIsPopulatedCorrectly(){
        var searchResultMeta:SearchResultMeta?
        do
        {
            let data = try JSONEncoder().encode(self.searchResultMetaJSON)
            searchResultMeta = try JSONDecoder().decode(SearchResultMeta.self, from: data)
        }
        catch
        {
            XCTFail()
        }
        XCTAssertEqual(searchResultMeta?.page, 1)
        XCTAssertEqual(searchResultMeta?.total, 100)
        XCTAssertEqual(searchResultMeta?.per_page, 10)
    }
}
