//
//  BusinessFilterViewController.swift
//  Yelp
//
//  Created by Ledesma Usop Jr. on 7/25/16.
//  Copyright © 2016 Ledesma Usop. All rights reserved.
//

import UIKit

class BusinessFilterViewController: UIViewController {
    
    let cancelButton = UIButton()
    var cancelNavBarItem : UIBarButtonItem!
    
    let saveButton = UIButton()
    var saveNavBarItem : UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavItems()

        // Do any additional setup after loading the view.
    }
    
    func prepareNavItems() {
        
        saveButton.setTitle("Save", forState: UIControlState.Normal)
        saveButton.titleLabel!.font = UIFont(name: saveButton.titleLabel!.font.fontName, size: 13)
        
        self.saveNavBarItem = UIBarButtonItem(customView: saveButton)
        self.navigationItem.rightBarButtonItem = self.saveNavBarItem
        
        saveButton.addTarget(self, action: #selector(BusinessFilterViewController.onSearchButtonDown(_:)), forControlEvents: UIControlEvents.TouchDown)
        
        saveButton.addTarget(self, action: #selector(BusinessFilterViewController.onSearchButtonUp(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        saveButton.addTarget(self, action: #selector(BusinessFilterViewController.onSearchButtonUp(_:)), forControlEvents: UIControlEvents.TouchUpOutside)
        
        cancelButton.setTitle("Cancel", forState: UIControlState.Normal)
        cancelButton.titleLabel!.font = UIFont(name: cancelButton.titleLabel!.font.fontName, size: 13)
        
        self.cancelNavBarItem = UIBarButtonItem(customView: cancelButton)
        self.navigationItem.leftBarButtonItem = self.cancelNavBarItem
        
        cancelButton.addTarget(self, action: #selector(BusinessFilterViewController.onCancelButtonDown(_:)), forControlEvents: UIControlEvents.TouchDown)
        
        cancelButton.addTarget(self, action: #selector(BusinessFilterViewController.onCancelButtonUp(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        cancelButton.addTarget(self, action: #selector(BusinessFilterViewController.onCancelButtonUp(_:)), forControlEvents: UIControlEvents.TouchUpOutside)
        
        
        
        
    }
    
    func onSearchButtonDown(btn:UIButton) {
        UIHelper.stylizeButton(btn,state: UIControlState.Highlighted)
    }
    
    
    func onSearchButtonUp(btn:UIButton) {
        UIHelper.stylizeButton(btn,state: UIControlState.Normal)
    }
    
    func onCancelButtonDown(btn:UIButton) {
        UIHelper.stylizeButton(btn,state: UIControlState.Highlighted)
    }
    
    
    func onCancelButtonUp(btn:UIButton) {
        UIHelper.stylizeButton(btn,state: UIControlState.Normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UIHelper.stylizeButton(self.saveButton,state: UIControlState.Normal)
        UIHelper.stylizeButton(self.cancelButton,state: UIControlState.Normal)
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
