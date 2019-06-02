//
//  EventCell.swift
//  AssignmentExpedia
//
//  Created by Saalis Umer on 6/1/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import UIKit
import Kingfisher
class EventCell: UITableViewCell
{
    @IBOutlet weak var imageViewEvent: UIImageView!
    @IBOutlet weak var titleLabelEvent:UILabel!
    @IBOutlet weak var venueEvent:UILabel!
    @IBOutlet weak var dateEvent:UILabel!
    @IBOutlet weak var favoriteImage:UIImageView!

    var event:Event?{
        didSet{
            if let event = self.event
            {
                self.titleLabelEvent.text = event.title
                self.venueEvent.text = event.venue?.display_location
                if let dateStr = event.announce_date
                {
                    self.dateEvent.text = Date.getDateFromyyyyMMddHHmmssZString(str: dateStr).getDateInDayDateMonthYearTimeFormat()
                }
                if let _ = event.performers?.count
                {
                    if let image = event.performers?[0].image
                    {
                        if let url = URL(string:image)
                        {
                            self.imageViewEvent.kf.setImage(with: url, placeholder: UIImage(named:"placeholder"))
                        }
                    }
                    else
                    {
                        self.imageViewEvent.image = UIImage(named:"cross")
                    }
                }
                
                self.updateFavoriteImageState()
                
                if let id = self.event?.id
                {
                    NotificationCenter.default.addObserver(self, selector: #selector(self.notificationHandlerLike(notif:)), name: NSNotification.Name(rawValue: "\(id)"), object: nil)
                }
            }
            else
            {
                self.prepareForReuse()
            }
        }
    }
    
    func updateFavoriteImageState()
    {
        self.favoriteImage.isHidden = !(self.event?.isFavorite ?? false)
    }
    
    @objc func notificationHandlerLike(notif:Notification)
    {
        self.updateFavoriteImageState()
    }
    
    override func prepareForReuse() {
        self.titleLabelEvent.text = ""
        self.venueEvent.text = ""
        self.dateEvent.text = ""
        self.imageViewEvent.image = nil
        self.favoriteImage.isHidden = true
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        self.contentView.backgroundColor = .white
        self.imageViewEvent.layer.cornerRadius = 7.0
        self.imageViewEvent.clipsToBounds = true
        self.imageViewEvent.contentMode = .scaleAspectFill
    }
    
    override var reuseIdentifier: String?
    {
        return EventCell.reuseIdentifier()
    }
    
    class func reuseIdentifier()->String
    {
        return "EventCell"
    }
}
