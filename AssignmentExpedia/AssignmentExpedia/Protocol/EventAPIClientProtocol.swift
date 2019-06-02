//
//  APIClientProtocol.swift
//  AssignmentExpedia
//
//  Created by Saalis Umer on 5/27/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import Foundation
protocol EventAPIClientProtocol {
    func loadEvents(keyword: String, pageNumber: Int, completion: @escaping (Error?) -> Void)
    func cancelTask()
}

