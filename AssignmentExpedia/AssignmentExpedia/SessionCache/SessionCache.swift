//
//  SessionCache.swift
//  AssignmentExpedia
//
//  Created by Saalis Umer on 5/27/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import Foundation
class SessionCache{
    static let sharedCache = SessionCache()
    private var searchResult:SearchResult?
    private let queue = DispatchQueue(label: "SEARCH_RESULT_QUEUE", attributes: .concurrent)
    private var favoriteIds = [Int:Bool]()
    
    init() {
        let key = "FAVORITES"
        if let arr = UserDefaults.standard.value(forKey: key) as? [Int]
        {
            for str in arr
            {
                self.favoriteIds[str] = true
            }
        }
    }
    
    func saveSearchResult(newSearchResult:SearchResult)
    {
        queue.async(group: nil, qos: .default, flags: .barrier) {
            var updateCase:Bool = false
            if let oldSearchResult = self.searchResult{
                if let keyOld = oldSearchResult.meta?.keyword
                {
                    if let keyNew = newSearchResult.meta?.keyword
                    {
                        if keyNew == keyOld
                        {
                            updateCase = true
                        }
                    }
                }
            }
            
            if updateCase
            {
                self.updateSearchResult(result: newSearchResult)
            }
            else
            {
                self.replaceSearchResult(result: newSearchResult)
            }
        }
    }
    
    func clearSesarchResult()
    {
        queue.async(group: nil, qos: .default, flags: .barrier) {
            self.searchResult = nil
        }
    }
    
    private func replaceSearchResult(result:SearchResult)
    {
        self.searchResult = result.copy() as? SearchResult
    }
    
    private func updateSearchResult(result:SearchResult)
    {
        self.searchResult?.meta = result.meta
        if let newEvents = result.events
        {
            self.searchResult?.events?.append(contentsOf: newEvents)
        }
    }
    
    func getSearchResult()->SearchResult?
    {
        var srchResult:SearchResult?
        queue.sync {
            srchResult = self.searchResult
        }
        return srchResult
    }
    
    func markAsFavorite(eventId:Int)// Not synchronizedMain thread only
    {
        let key = "FAVORITES"
        if var arr = UserDefaults.standard.value(forKey: key) as? [Int]
        {
            if arr.contains(eventId)
            {
                return
            }
            else
            {
                arr.append(eventId)
            }
            UserDefaults.standard.setValue(arr, forKey: key)
            UserDefaults.standard.synchronize()
        }
        else
        {
            var arr = [Int]()
            arr.append(eventId)
            UserDefaults.standard.setValue(arr, forKey: key)
            UserDefaults.standard.synchronize()
        }
        self.favoriteIds[eventId] = true
        NotificationCenter.default.post(NSNotification(name: NSNotification.Name(rawValue: "\(eventId)"), object: nil) as Notification)
    }
    
    func markAsUnFavorite(eventId:Int) // Not synchronizedMain thread only
    {
        let key = "FAVORITES"
        if var arr = UserDefaults.standard.value(forKey: key) as? [Int]
        {
            if arr.contains(eventId)
            {
                let p = arr
                for i in 0..<p.count
                {
                    if p[i] == eventId
                    {
                        arr.remove(at: i)
                    }
                }
                UserDefaults.standard.setValue(arr, forKey: key)
                UserDefaults.standard.synchronize()
            }
        }
        self.favoriteIds.removeValue(forKey: eventId)
        NotificationCenter.default.post(NSNotification(name: NSNotification.Name(rawValue: "\(eventId)"), object: nil) as Notification)
    }
    
    func isFavorite(eventId:Int)->Bool
    {
        return self.favoriteIds[eventId] ?? false
    }
}
