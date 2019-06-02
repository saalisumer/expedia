//
//  SearchResult.swift
//  AssignmentExpedia
//
//  Created by Saalis Umer on 5/27/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import Foundation
class SearchResult:Decodable,NSCopying{
    var meta:SearchResultMeta?
    var events:[Event]?
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = SearchResult()
        copy.meta = self.meta
        copy.events = self.events
        return copy
    }
}
