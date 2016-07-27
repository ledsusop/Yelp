//
//  SwitchCell.swift
//  Yelp
//
//  Created by Ledesma Usop Jr. on 7/26/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {

    @IBOutlet weak var txtLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    
    var delegate: CustomTableCellDelegate!
    var cellDescriptor:[String:String]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if delegate != nil {
            delegate.onSelectedCell(selected, source: self, descriptor:cellDescriptor)
        }
    }

    @IBAction func onValueChanged(sender: UISwitch) {
        if delegate != nil {
            delegate.onValueChanged(sender.on, source: self, descriptor:cellDescriptor)
        }
    }
}
