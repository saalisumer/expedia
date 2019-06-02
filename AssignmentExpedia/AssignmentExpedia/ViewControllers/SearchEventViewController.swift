//
//  SearchEventViewController.swift
//  AssignmentExpedia
//
//  Created by Saalis Umer on 6/1/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import UIKit

class SearchEventViewController: UIViewController {
    @IBOutlet weak var searchBar:CustomTextField!
    @IBOutlet weak var searchBackground:UIView!
    @IBOutlet weak var widthOfSearchBar:NSLayoutConstraint!
    @IBOutlet weak var searchButton:UIButton!
    @IBOutlet weak var tableView:UITableView!
    
    let sessionCache:SessionCache = SessionCache.sharedCache
    var eventAPIClient:EventAPIClientProtocol?
    var eventTableViewDatasource:EventTableViewDatasource?
    var eventTableViewDelegate:EventTableViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventTableViewDatasource = EventTableViewDatasource(events: [], reuseIdentifiers: [EventCell.reuseIdentifier()], tableView: self.tableView)
        self.eventTableViewDelegate = EventTableViewDelegate(datasource:self.eventTableViewDatasource, delegate: self, tableView: self.tableView)
        self.initializeViews()
    }
    
    func initializeViews(){
        self.view.backgroundColor = CustomColors.searchBarBackgroundColor
        self.searchBackground.backgroundColor = CustomColors.searchBarBackgroundColor
        let imageView = UIImageView(image: UIImage(named:"search"))
        imageView.backgroundColor = .clear
        self.searchBar.leftView = imageView
        self.searchBar.leftViewMode = .always
        self.searchBar.backgroundColor = CustomColors.searchBarTextBackgroundColor
        self.searchBar.clearButtonMode = .whileEditing
        self.searchBar.tintColor = .white
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = .search
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        self.searchBar.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        self.updateWidthOfSearchBar(width: self.getWidthOfSearchBar(isEditing: false, screenWidth: UIScreen.main.bounds.size.width,padding: 10, cancelSearchWidth: self.searchButton.bounds.size.width), animation: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Actions
    @IBAction func didTapCancel(){
        self.searchBar.resignFirstResponder()
    }
    
    // MARK: Internal Variables and Methods
    internal let paddingSearchBarHorizontal = 10.0
    internal func getWidthOfSearchBar(isEditing:Bool, screenWidth:CGFloat, padding:Double, cancelSearchWidth:CGFloat)->CGFloat
    {
        if isEditing {
            return screenWidth - (CGFloat(3.0*padding) + cancelSearchWidth)
        }
        else
        {
            return screenWidth - CGFloat(2.0*padding)
        }
    }
    
    internal func updateWidthOfSearchBar(width:CGFloat, animation:Bool)
    {
        if animation {
            UIView.animate(withDuration: 0.1) {
                self.widthOfSearchBar.constant = width
                self.view.layoutIfNeeded()
            }
        }
        else
        {
            self.widthOfSearchBar.constant = width
            self.view.layoutIfNeeded()
        }
    }
    
    internal func fetchEventsForKeyword(keyword:String, pageNumber:Int)
    {
        if let page = self.sessionCache.getSearchResult()?.meta?.page {
            guard self.sessionCache.getSearchResult()?.meta?.keyword != keyword || pageNumber > page else
            {
                return
            }
        }
        
        if let client = self.eventAPIClient
        {
            client.cancelTask()
            self.eventAPIClient = nil
        }
        
        self.setEventAPIClient(client: EventAPIClient())
        self.makeAPICallFor(keyword: keyword, pageNumber: pageNumber,completion:{})
    }
    
    func setEventAPIClient<A:EventAPIClientProtocol>(client:A?)
    {
        self.eventAPIClient = client
    }
    
    internal func makeAPICallFor(keyword:String, pageNumber:Int, completion:@escaping (()->Void))
    {
        self.eventAPIClient?.loadEvents(keyword: keyword, pageNumber: pageNumber, completion: { (err) in
            if let error = err
            {
                if error.localizedDescription != CustomError.requestCancelled.localizedDescription && error.localizedDescription != "cancelled"
                {
                    DispatchQueue.main.async {
                        self.view.makeToast(error.localizedDescription)
                    }
                }
                return
            }
            
            DispatchQueue.main.async {
                self.updateDatasource()
                completion()
            }
        })
    }

    
    @objc internal func textFieldDidChange()
    {
        if self.searchBar.text?.count == 0
        {
            if let client = self.eventAPIClient
            {
                client.cancelTask()
                self.eventAPIClient = nil
            }
            self.sessionCache.clearSesarchResult()
            self.updateDatasource()
        }
        else if let keyword = self.searchBar.text
        {
            self.fetchEventsForKeyword(keyword:keyword , pageNumber: 1)
        }
    }
    
    internal func updateDatasource()
    {
        if let dataSource = self.eventTableViewDatasource
        {
            dataSource.events = self.sessionCache.getSearchResult()?.events
        }
    }
}

extension SearchEventViewController:UITextFieldDelegate
{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.updateWidthOfSearchBar(width: self.getWidthOfSearchBar(isEditing: true,screenWidth: UIScreen.main.bounds.size.width,padding: 10, cancelSearchWidth: self.searchButton.bounds.size.width), animation: true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.updateWidthOfSearchBar(width: self.getWidthOfSearchBar(isEditing: false,screenWidth: UIScreen.main.bounds.size.width,padding: 10, cancelSearchWidth: self.searchButton.bounds.size.width), animation: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension SearchEventViewController:EventDelegate
{
    func loadNextPage() {
        if let currPage = self.sessionCache.getSearchResult()?.meta?.page,let per_page = self.sessionCache.getSearchResult()?.meta?.per_page, let total =  self.sessionCache.getSearchResult()?.meta?.total, let keyword =  self.sessionCache.getSearchResult()?.meta?.keyword{
            if per_page*currPage < total{
                self.fetchEventsForKeyword(keyword: keyword, pageNumber: currPage+1)
                self.view.makeToast("Fetching More...")
            }
            else
            {
                self.view.makeToast("End of Results")
            }
        }
    }
    
    func didSelectEvent(event: Event) {
        if let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: EventDetailViewController.identifier()) as? EventDetailViewController
        {
            vc.view.alpha = 1.0
            vc.event = event
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

