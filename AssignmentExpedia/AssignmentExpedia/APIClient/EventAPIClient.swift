//
//  EventAPIClient.swift
//  AssignmentExpedia
//
//  Created by Saalis Umer on 5/27/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import Foundation
class EventAPIClient:EventAPIClientProtocol{
    var urlSessionDataTask:URLSessionDataTask?
    var completionBlock:((Error?) -> Void)?
    func loadEvents(keyword: String, pageNumber: Int, completion: @escaping (Error?) -> Void) {
        self.completionBlock = completion
        
        guard pageNumber >= 1 else
        {
            completion(CustomError.invalidPageNumberRequested)
            return
        }
        
        let url = self.getURL(keyword: keyword, pageNumber: pageNumber)
        guard url != nil else{
            completion(CustomError.invalidURL)
            return
        }
        
        self.urlSessionDataTask = URLSession.shared.dataTask(with: url!) { (data, response, err) in
            guard data != nil && err == nil else{
                completion(err)
                return
            }
            
            guard data != nil else{
                SessionCache.sharedCache.clearSesarchResult()
                completion(CustomError.invalidResponse)
                return
            }
            
            do{
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data!)
                searchResult.meta?.keyword = keyword
                SessionCache.sharedCache.saveSearchResult(newSearchResult: searchResult)
                completion(nil)
            }
            catch
            {
                SessionCache.sharedCache.clearSesarchResult()
                completion(error)
            }
        }
        self.urlSessionDataTask?.resume()
    }
    
    func cancelTask()
    {
        if let task = self.urlSessionDataTask {
            task.cancel()
            if let compBlock = self.completionBlock
            {
                compBlock(CustomError.requestCancelled)
                self.completionBlock = nil
            }
        }
    }
    
    func getURL(keyword:String, pageNumber:Int) -> URL?
    {
        var urlStr = APIURLS.SEAT_GEEK_SEARCH_API
        urlStr = urlStr.replacingOccurrences(of: APIPlaceholders.query.rawValue, with: keyword)
        urlStr = urlStr.replacingOccurrences(of: APIPlaceholders.client_id.rawValue, with: SeatGeekConstants.SEAT_GEEK_CLIENT_ID)
        urlStr = urlStr.replacingOccurrences(of: APIPlaceholders.client_secret_key.rawValue, with: SeatGeekConstants.SEAT_GEEK_SECRET_KEY)
        urlStr = urlStr.replacingOccurrences(of: APIPlaceholders.page_no.rawValue, with: "\(pageNumber)")
        urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? urlStr
       return URL(string: urlStr)
    }
}


class MockAPIClient:EventAPIClientProtocol
{
    static let searchResultJSONSample = ["meta":["per_page":10,"total":100,"page":1],"events":[["id":12345,"title":"test title1","announce_date":"2018-10-30T00:00:00","performers":[["image":"https://seatgeek.com/images/performers-landscape/pittsburgh-pirates-bcb7ec/10/huge.jpg"],["image":"https://seatgeek.com/images/performers-landscape/pittsburgh-pirates-bcb7ec/10/huge.jpg"]],"venue":["display_location":"Delhi, India"]],["id":12346,"title":"test title1","announce_date":"2018-10-30T00:00:00","performers":[["image":"https://seatgeek.com/images/performers-landscape/pittsburgh-pirates-bcb7ec/10/huge.jpg"],["image":"https://seatgeek.com/images/performers-landscape/pittsburgh-pirates-bcb7ec/10/huge.jpg"]],"venue":["display_location":"Delhi, India"]],["id":12347,"title":"test title3","announce_date":"2018-10-30T00:00:00","performers":[["image":"https://seatgeek.com/images/performers-landscape/pittsburgh-pirates-bcb7ec/10/huge.jpg"],["image":"https://seatgeek.com/images/performers-landscape/pittsburgh-pirates-bcb7ec/10/huge.jpg"]],"venue":["display_location":"Delhi, India"]]]] as [String : Any]
    
    func loadEvents(keyword: String, pageNumber: Int, completion: @escaping (Error?) -> Void) {
        do{
            let data = try JSONSerialization.data(withJSONObject: MockAPIClient.searchResultJSONSample, options: .prettyPrinted)
            let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
            searchResult.meta?.keyword = keyword
            SessionCache.sharedCache.saveSearchResult(newSearchResult: searchResult)
            completion(nil)
        }
        catch
        {
            SessionCache.sharedCache.clearSesarchResult()
            completion(error)
        }
    }
    
    func cancelTask()
    {
        
    }
}

