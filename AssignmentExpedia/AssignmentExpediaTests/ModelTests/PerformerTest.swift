//
//  PerformerTest.swift
//  AssignmentExpediaTests
//
//  Created by Saalis Umer on 5/27/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import XCTest
@testable import AssignmentExpedia
class PerformerTest: XCTestCase {
    var performerDictionaryOne:[String:String]?
    var performerDictionaryTwo:[String:String]?

    override func setUp() {
        self.performerDictionaryOne = ["image":"https://seatgeek.com/images/performers-landscape/pittsburgh-pirates-bcb7ec/10/huge.jpg"]
        self.performerDictionaryTwo = [:]
    }

    override func tearDown() {
        self.performerDictionaryOne = nil
        self.performerDictionaryTwo = nil
    }

    func testPerformerImageIsCorrectlyPopulated() {
        var performer:Performer?
        do
        {
            let data = try JSONEncoder().encode(self.performerDictionaryOne)
            performer = try JSONDecoder().decode(Performer.self, from: data)
        }
        catch
        {
            XCTFail()
        }
        XCTAssertEqual(performer?.image, "https://seatgeek.com/images/performers-landscape/pittsburgh-pirates-bcb7ec/10/huge.jpg")
    }
    
    func testVenueDisplayLocationIsNil() {
        var performer:Performer?
        do
        {
            let data = try JSONEncoder().encode(self.performerDictionaryTwo)
            performer = try JSONDecoder().decode(Performer.self, from: data)
        }
        catch
        {
            XCTFail()
        }
        XCTAssertEqual(performer?.image, nil)
    }
}
