//
//  EventDetailViewController.swift
//  AssignmentExpedia
//
//  Created by Saalis Umer on 6/2/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    var event:Event?
    {
        didSet
        {
            self.titleLabel.text = self.event?.title
            if let dateStr = self.event?.announce_date
            {
                self.dateLabe.text = Date.getDateFromyyyyMMddHHmmssZString(str: dateStr).getDateInDayDateMonthYearTimeFormat()
            }
            self.locationLabel.text = self.event?.venue?.display_location
            if let _ = event?.performers?.count
            {
                if let image = event?.performers?[0].image
                {
                    if let url = URL(string:image)
                    {
                        self.imageView.kf.setImage(with:url)
                    }
                }
                else
                {
                    self.imageView.image = UIImage(named:"cross")
                }
            }
            self.updateLikeButtonState()
            
            if let id = self.event?.id
            {
                NotificationCenter.default.addObserver(self, selector: #selector(self.notificationHandlerLike(notif:)), name: NSNotification.Name(rawValue: "\(id)"), object: nil)
            }
        }
    }
    
    func updateLikeButtonState()
    {
        if let a = event?.isFavorite {
            if a == true
            {
                self.likeButton.setImage(UIImage(named:"heart_red"), for: .normal)
            }
            else
            {
                self.likeButton.setImage(UIImage(named:"heart_white"), for: .normal)
            }
        }
        else
        {
            self.likeButton.setImage(UIImage(named:"heart_white"), for: .normal)
            
        }
    }
    
    @objc func notificationHandlerLike(notif:Notification)
    {
        self.updateLikeButtonState()
    }
    
    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var imageView:UIImageView!
    @IBOutlet var likeButton:UIButton!
    @IBOutlet var dateLabe:UILabel!
    @IBOutlet var locationLabel:UILabel!

    override func viewDidLoad() {
        self.imageView.layer.cornerRadius = 7.0
        self.imageView.clipsToBounds = true
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    static func identifier()->String{
        return "EventDetailViewController"
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    @IBAction func didTapLikeButton(){
        if let eventId = self.event?.id
        {
            if let favorited = self.event?.isFavorite
            {
                if favorited
                {
                    SessionCache.sharedCache.markAsUnFavorite(eventId: eventId)
                }
                else
                {
                    SessionCache.sharedCache.markAsFavorite(eventId: eventId)
                }
            }
        }
    }
    
    @IBAction func didTapBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}
