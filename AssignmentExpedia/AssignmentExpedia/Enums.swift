//
//  Enums.swift
//  AssignmentExpedia
//
//  Created by Saalis Umer on 5/27/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import Foundation
enum APIPlaceholders:String
{
    case client_id = "{client_id}"
    case client_secret_key = "{client_secret_key}"
    case query = "{query}"
    case page_no = "{page_no}"
}

enum CustomError: Error {
    case invalidResponse
    case invalidURL
    case invalidKeyword
    case invalidPageNumberRequested
    case requestCancelled
}


