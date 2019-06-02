//
//  Constant.swift
//  AssignmentExpedia
//
//  Created by Saalis Umer on 5/27/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import Foundation
import UIKit

struct SeatGeekConstants
{
    static let SEAT_GEEK_CLIENT_ID:String = "MTY3NzAzNjd8MTU1ODc5OTIyNi40NA"
    static let SEAT_GEEK_SECRET_KEY:String = "451afc63ce1aeba89ec1ecf41ed61aadf7cd4d2fc47ee3df591f7d284fdb8b49"
}

struct APIURLS{
    static let SEAT_GEEK_SEARCH_API = "https://api.seatgeek.com/2/events?client_id=\(APIPlaceholders.client_id.rawValue)&client_secret=\(APIPlaceholders.client_secret_key.rawValue)&q=\(APIPlaceholders.query.rawValue)&page=\(APIPlaceholders.page_no.rawValue)&per_page=20"
}


struct CustomColors
{
    static let searchBarBackgroundColor = UIColor(red: 15.0/255.0, green: 36.0/255.0, blue: 54.0/255.0, alpha: 1.0)
    static let searchBarTextBackgroundColor = UIColor(red: 31.0/255.0, green: 54.0/255.0, blue: 70.0/255.0, alpha: 1.0)
}
