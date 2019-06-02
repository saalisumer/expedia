//
//  EventTableViewDelegate.swift
//  AssignmentExpedia
//
//  Created by Saalis Umer on 6/2/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import UIKit

protocol EventDelegate {
    func didSelectEvent(event:Event)
    func loadNextPage()
}

class EventTableViewDelegate: NSObject,UITableViewDelegate {
    weak var datasource:EventTableViewDatasource?
    weak var tableView:UITableView?
    var delegate:EventDelegate?
    
    init(datasource:EventTableViewDatasource?, delegate:EventDelegate, tableView:UITableView) {
        super.init()
        self.delegate = delegate
        self.datasource = datasource
        self.tableView = tableView
        self.tableView!.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let del = self.delegate, let ds = self.datasource {
           del.didSelectEvent(event: ds.events![indexPath.item])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let cell =  self.tableView?.visibleCells.last
        {
            if let indexPath = self.tableView?.indexPath(for:cell)
            {
                if indexPath.row > ((self.datasource?.events?.count ?? 0) - 7)
                {
                    if let del = self.delegate
                    {
                        del.loadNextPage()
                    }
                }
            }
        }
    }
}
