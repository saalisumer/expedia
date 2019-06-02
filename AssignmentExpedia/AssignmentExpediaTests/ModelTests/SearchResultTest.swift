//
//  SearchResultTest.swift
//  AssignmentExpediaTests
//
//  Created by Saalis Umer on 5/27/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import XCTest
@testable import AssignmentExpedia
class SearchResultTest: XCTestCase {
    static let searchResultJSONSample = ["meta":["per_page":10,"total":100,"page":1],"events":[["id":12345,"title":"test title1","announce_date":"2018-10-30T00:00:00","performers":[["image":"https://seatgeek.com/images/performers-landscape/pittsburgh-pirates-bcb7ec/10/huge.jpg"],["image":"https://seatgeek.com/images/performers-landscape/pittsburgh-pirates-bcb7ec/10/huge.jpg"]],"venue":["display_location":"Delhi, India"]],["id":12346,"title":"test title1","announce_date":"2018-10-30T00:00:00","performers":[["image":"https://seatgeek.com/images/performers-landscape/pittsburgh-pirates-bcb7ec/10/huge.jpg"],["image":"https://seatgeek.com/images/performers-landscape/pittsburgh-pirates-bcb7ec/10/huge.jpg"]],"venue":["display_location":"Delhi, India"]],["id":12347,"title":"test title3","announce_date":"2018-10-30T00:00:00","performers":[["image":"https://seatgeek.com/images/performers-landscape/pittsburgh-pirates-bcb7ec/10/huge.jpg"],["image":"https://seatgeek.com/images/performers-landscape/pittsburgh-pirates-bcb7ec/10/huge.jpg"]],"venue":["display_location":"Delhi, India"]]]] as [String : Any]
    var searchResultJSON:[String:Any]?
    override func setUp() {
        self.searchResultJSON = SearchResultTest.searchResultJSONSample
    }

    override func tearDown() {
        self.searchResultJSON = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIfSearchResultIsPopulatedProperly()
    {
        do{
            let data = try JSONSerialization.data(withJSONObject: self.searchResultJSON!, options: .prettyPrinted)
            let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
            XCTAssertNotNil(searchResult.meta)
            XCTAssertEqual(searchResult.events?.count,3)
        }
        catch
        {
            XCTFail()
        }
    }
}
