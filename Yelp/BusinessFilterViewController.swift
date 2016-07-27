//
//  BusinessFilterViewController.swift
//  Yelp
//
//  Created by Ledesma Usop Jr. on 7/25/16.
//  Copyright © 2016 Ledesma Usop. All rights reserved.
//

import UIKit

protocol CustomTableCellDelegate{
    func onSelectedCell(selected:Bool, source:UITableViewCell, descriptor:[String:String])
    func onValueChanged(isOn: Bool, source:SwitchCell, descriptor:[String:String])
}

class BusinessFilterViewController: UITableViewController, CustomTableCellDelegate {
    
    let cancelButton = UIButton()
    let saveButton = UIButton()
    
    var cellDescriptors = CellDescriptorHelper.getCellDescriptors()
    var sectionDescriptors = CellDescriptorHelper.getSections()
    
    var preferencesValues = ["deal":"true","sort":"bestmatch","distance":"auto","category":"newamerican"]
    
    @IBOutlet var filterTableView: UITableView!
    
    var cancelNavBarItem : UIBarButtonItem!
    var saveNavBarItem : UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavItems()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        registerFilterTableCells()
    }
    
    
    
    func registerFilterTableCells() {
        filterTableView.registerNib(UINib(nibName: "NormalCell", bundle: nil), forCellReuseIdentifier: "idCellNormal")
        filterTableView.registerNib(UINib(nibName: "SwitchCell", bundle: nil), forCellReuseIdentifier: "idCellSwitch")
        filterTableView.registerNib(UINib(nibName: "ValuePickerCell", bundle: nil), forCellReuseIdentifier: "idCellValuePicker")
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionDescriptors.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int = 0
        let sectionDescriptor = sectionDescriptors[section]
        for var row in cellDescriptors{
            if row["section"] == sectionDescriptor["id"]{
                count+=1
            }
        }
        
        return count
    }
    
    func onSelectedCell(selected:Bool, source:UITableViewCell, descriptor:[String:String]){
        if selected {
            var sectionindex = 0
            for var sectionDescriptor in self.sectionDescriptors{
                if sectionDescriptor["id"] == descriptor["section"] {
                    
                    if sectionDescriptor["expandable"] == "true" {
                        sectionDescriptor["isExpanded"] = sectionDescriptor["isExpanded"] == "true" ? "false" : "true"
                        preferencesValues[sectionDescriptor["id"]!] = descriptor["value"]
                        self.sectionDescriptors[sectionindex] = sectionDescriptor
                        self.filterTableView.reloadSections(NSIndexSet(index: sectionindex), withRowAnimation: UITableViewRowAnimation.Fade)
                    }
                    
                    break
                }
                sectionindex+=1
            }
            
            
            
            
            
        }
    }
    
    func onValueChanged(isOn: Bool, source:SwitchCell, descriptor:[String:String]){
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let sectionDescriptor = sectionDescriptors[indexPath.section]
        
        let cellDescriptor = cellDescriptors[indexPath.row + Int(sectionDescriptor["rowOffset"]!)!]
        let cellType = cellDescriptor["type"]
        let currentValue = preferencesValues[sectionDescriptor["id"]!]
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellType!, forIndexPath: indexPath)
        
        if cellType == "idCellNormal"{
            (cell as! NormalCell).titleLabel.text = ""
            (cell as! NormalCell).detailLabel.text = cellDescriptor["label"]
            (cell as! NormalCell).delegate = self
            (cell as! NormalCell).cellDescriptor = cellDescriptor
        }else if cellType == "idCellValuePicker"{
            (cell as! ValuePickerCell).txtLabel.text = cellDescriptor["label"]
            (cell as! NormalCell).cellDescriptor = cellDescriptor
        }else if cellType == "idCellSwitch"{
            (cell as! SwitchCell).txtLabel.text = cellDescriptor["label"]
            (cell as! SwitchCell).cellDescriptor = cellDescriptor
        }else{
            cell = UITableViewCell() as UITableViewCell
            cell.textLabel?.text = cellDescriptor["label"]
        }
        
        if sectionDescriptor["expandable"] == "true" && currentValue != cellDescriptor["value"]{
            cell.hidden = sectionDescriptor["isExpanded"] != "true"
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let sectionDescriptor = sectionDescriptors[indexPath.section]
        let currentValue = preferencesValues[sectionDescriptor["id"]!]
        let cellDescriptor = cellDescriptors[indexPath.row + Int(sectionDescriptor["rowOffset"]!)!]
        
        if sectionDescriptor["expandable"] == "true" && currentValue != cellDescriptor["value"]{
            return sectionDescriptor["isExpanded"] == "true" ? 44 : 0
        }else{
            return 44
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionDescriptors[section]["label"]
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 44
    }

    
    func prepareNavItems() {
        
        self.navigationItem.title = "Filters"
        
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
        dismissViewControllerAnimated(true, completion:  nil)
    }
    
    func onCancelButtonDown(btn:UIButton) {
        UIHelper.stylizeButton(btn,state: UIControlState.Highlighted)
    }
    
    
    func onCancelButtonUp(btn:UIButton) {
        UIHelper.stylizeButton(btn,state: UIControlState.Normal)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
//    func getIndicesOfVisibleRows() {
//        visibleRowsPerSection.removeAll()
//        
//        for currentSectionCells in cellDescriptors {
//            var visibleRows = [Int]()
//            
//            for row in 0...((currentSectionCells as! [[String: AnyObject]]).count - 1) {
//                if currentSectionCells[row]["isVisible"] as! Bool == true {
//                    visibleRows.append(row)
//                }
//            }
//            
//            visibleRowsPerSection.append(visibleRows)
//        }
//    }
    
    
    /**override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let title = UILabel()
        title.font = UIFont.boldSystemFontOfSize(15.0)
        title.textColor = UIColor.blackColor()
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font=title.font
        header.textLabel?.textColor=title.textColor
    }**/
    
    
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
