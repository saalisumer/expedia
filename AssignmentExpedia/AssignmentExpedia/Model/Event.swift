//
//  Event.swift
//  AssignmentExpedia
//
//  Created by Saalis Umer on 5/26/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import Foundation
class Event:Decodable
{
    var id:Int
    var title:String?
    var announce_date:String?
    var performers:[Performer]?
    var venue:Venue?
    var isFavorite:Bool?
    {
        get
        {
            return SessionCache.sharedCache.isFavorite(eventId:self.id)
        }
    }
}
