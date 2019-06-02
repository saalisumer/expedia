//
//  VenueTest.swift
//  AssignmentExpediaTests
//
//  Created by Saalis Umer on 5/27/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import XCTest
@testable import AssignmentExpedia
class VenueTest: XCTestCase {
    var venueDictionaryOne:[String:String]?
    var venueDictionaryTwo:[String:String]?
    override func setUp() {
        self.venueDictionaryOne = ["display_location":"Delhi"]
        self.venueDictionaryTwo = [:]
    }

    override func tearDown() {
        self.venueDictionaryOne = nil
        self.venueDictionaryTwo = nil
    }

    func testVenueDisplayLocationIsCorrectlyPopulated() {
        var venue:Venue?
        do
        {
            let data = try JSONEncoder().encode(self.venueDictionaryOne)
            venue = try JSONDecoder().decode(Venue.self, from: data)
        }
        catch
        {
            XCTFail()
        }
        XCTAssertEqual(venue?.display_location, "Delhi")
    }

    func testVenueDisplayLocationIsNil() {
        var venue:Venue?
        do
        {
            let data = try JSONEncoder().encode(self.venueDictionaryTwo)
            venue = try JSONDecoder().decode(Venue.self, from: data)
        }
        catch
        {
            XCTFail()
        }
        XCTAssertEqual(venue?.display_location, nil)
    }}
