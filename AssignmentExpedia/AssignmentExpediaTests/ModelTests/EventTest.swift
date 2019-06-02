//
//  EventTest.swift
//  AssignmentExpediaTests
//
//  Created by Saalis Umer on 5/27/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import XCTest
//@testable import Event
class EventTest: XCTestCase {
    var eventJSON:[String:Any]?
    override func setUp() {
        self.eventJSON = ["id":12345,"title":"test title","announce_date":"2018-10-30T00:00:00","performers":[["image":"https://seatgeek.com/images/performers-landscape/pittsburgh-pirates-bcb7ec/10/huge.jpg"],["image":"https://seatgeek.com/images/performers-landscape/pittsburgh-pirates-bcb7ec/10/huge.jpg"]],"venue":["display_location":"Delhi, India"]]
    }

    override func tearDown() {
        self.eventJSON = nil
    }

    func testEventIsPopulatedCorrectly(){
        var data:Data
        var event:Event
        do
        {
            data = try JSONSerialization.data(withJSONObject: self.eventJSON!, options: .prettyPrinted)
            event = try JSONDecoder().decode(Event.self, from: data)
            XCTAssertEqual(event.id, 12345)
            XCTAssertEqual(event.announce_date, "2018-10-30T00:00:00")
            XCTAssertEqual(event.title, "test title")
            XCTAssertEqual(event.performers?.count, 2)
            XCTAssertEqual(event.venue?.display_location, "Delhi, India")
        }
        catch
        {
            XCTFail()
        }
    }
}
