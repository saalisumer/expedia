//
//  SearchResultMeta.swift
//  AssignmentExpedia
//
//  Created by Saalis Umer on 5/27/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import Foundation
class SearchResultMeta:Decodable
{
    var per_page:Int?
    var total:Int
    var page:Int?
    var keyword:String?
}
