//
//  UtilityExtensions.swift
//  AssignmentExpedia
//
//  Created by Saalis Umer on 6/2/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import Foundation
extension Date{
    static func getDateFromyyyyMMddHHmmssZString(str:String)->Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: str)!
        return date
    }
    
    func getDateInDayDateMonthYearTimeFormat()->String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm a"
        return dateFormatter.string(from: self)
    }
}
