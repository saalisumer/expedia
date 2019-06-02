//
//  EventTableViewDatasource.swift
//  AssignmentExpedia
//
//  Created by Saalis Umer on 6/2/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import UIKit

class EventTableViewDatasource: NSObject,UITableViewDataSource
{
    weak var tableView:UITableView!
    init(events:[Event], reuseIdentifiers:[String],tableView:UITableView) {
        super.init()
        self.tableView = tableView
        self.tableView.dataSource = self
        for identifier in reuseIdentifiers
        {
            self.tableView?.register(UINib(nibName: identifier, bundle: Bundle.main), forCellReuseIdentifier: identifier)
        }
        self.events = events
    }
    
    var events:[Event]?
    {
        didSet
        {
            self.tableView?.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView?.dequeueReusableCell(withIdentifier: EventCell.reuseIdentifier(), for: indexPath) as? EventCell else {return UITableViewCell()}
        cell.event = self.events?[indexPath.item]
        return cell
    }
}
