//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Ledesma Usop on 07/25/16.
//  Copyright (c) 2016 Ledesma Usop. All rights reserved.
//

import UIKit
import MBProgressHUD


class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let ITEMS_PER_PAGE = 20
    let DEFAULT_SEARCH_TERM = "Restaurants"
    let searchBar = UISearchBar()
    let barButton = UIButton()
    var searchTerm = "Restaurants"
    var filterNavBarItem : UIBarButtonItem!
    var businesses: [Business] = [Business]()
    var initialDefaultPreferences = ["deal":"true","sort":"bestmatch","distance":"0","category":"newamerican"]
    let defaults = NSUserDefaults.standardUserDefaults()
    var preferences:[String:String]! = [String:String]()
    var isMoreDataLoading = false
    let refreshControl = UIRefreshControl()
    
    func refreshPreferences(){
        
        for defKey in self.initialDefaultPreferences.keys{
            if let curValue = defaults.stringForKey(defKey){
                preferences[defKey] = curValue
                print(defKey + " is already set with value "+curValue)
            }else{
                defaults.setValue(self.initialDefaultPreferences[defKey], forKey: defKey)
                preferences[defKey] = self.initialDefaultPreferences[defKey]
                print(defKey + " is not yet set. Setting initial default value " + defaults.stringForKey(defKey)!)
            }
        }
        doSearch(true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                isMoreDataLoading = true
                doSearch(false)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavItems()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.refreshControl.addTarget(self, action: #selector(self.refreshSearch(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        tableView.addSubview(self.refreshControl)
        
        refreshPreferences()
    }
    
    func refreshSearch(refreshControl: UIRefreshControl){
        doSearch(true, refreshControl: refreshControl)
    }
    
    func doSearch(replaceItems: Bool, refreshControl: UIRefreshControl? = nil) {
        
        self.searchTerm = searchBar.text ?? DEFAULT_SEARCH_TERM
        
        if refreshControl != nil {
            refreshControl!.endRefreshing()
        }
        
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        var sortMode:YelpSortMode = .Distance
        switch self.preferences["sort"]! {
            case "distance":
                sortMode = .Distance
            case "bestmatch":
                sortMode = .BestMatched
            case "highestrated":
                sortMode = .HighestRated
            default:
                sortMode = .Distance

        }
        
        Business.searchWithTerm(self.searchTerm, sort: sortMode, categories: [self.preferences["category"]!], deals: (self.preferences["deal"]! == "true"), distance: Int(self.preferences["distance"]!), limit: replaceItems ? nil : ITEMS_PER_PAGE, offset: replaceItems ? nil : self.businesses.count) { (businesses: [Business]!, error: NSError!) -> Void in
            
            if replaceItems {
                self.businesses = businesses
            }else{
                self.businesses.appendContentsOf(businesses)
            }
            
            self.tableView.reloadData()
            if businesses != nil {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            self.isMoreDataLoading = false
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
    }
    
    func prepareNavItems() {
        
        barButton.setTitle("Filter", forState: UIControlState.Normal)
        barButton.titleLabel!.font = UIFont(name: barButton.titleLabel!.font.fontName, size: 13)
        
        self.filterNavBarItem = UIBarButtonItem(customView: barButton)
        self.navigationItem.leftBarButtonItem = self.filterNavBarItem
        
        barButton.addTarget(self, action: #selector(BusinessesViewController.onFilterButtonDown(_:)), forControlEvents: UIControlEvents.TouchDown)
        
        barButton.addTarget(self, action: #selector(BusinessesViewController.onFilterButtonUp(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        barButton.addTarget(self, action: #selector(BusinessesViewController.onFilterButtonUp(_:)), forControlEvents: UIControlEvents.TouchUpOutside)
        
        searchBar.delegate = self
        searchBar.placeholder = DEFAULT_SEARCH_TERM
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
    }
    
    func onFilterButtonDown(obj:AnyObject) {
        UIHelper.stylizeButton(self.barButton,state: UIControlState.Highlighted)
    }
    
    
    func onFilterButtonUp(obj:AnyObject) {
        UIHelper.stylizeButton(self.barButton,state: UIControlState.Normal)
        self.performSegueWithIdentifier("segueToFilter", sender: self)
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        searchBar.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText==""{
            self.searchTerm = DEFAULT_SEARCH_TERM
        }else{
            self.searchTerm = searchText
        }
        
        NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: #selector(self.searchFromSearchBar), object: nil)
        self.performSelector(#selector(self.searchFromSearchBar), withObject: nil, afterDelay: 0.7)
    }
    
    func searchFromSearchBar(){
        doSearch(true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UIHelper.stylizeButton(self.barButton,state: UIControlState.Normal)
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return businesses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        
        cell.rowIndex = indexPath.row + 1
        cell.business = businesses[indexPath.row]
        
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         let destinationController = segue.destinationViewController.childViewControllers[0] as! BusinessFilterViewController
         destinationController.firstViewController = self
         destinationController.preferencesValues = self.preferences
     }
    
    
}


