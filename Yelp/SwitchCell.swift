//
//  SwitchCell.swift
//  Yelp
//
//  Created by Ledesma Usop Jr. on 7/26/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

protocol SwitchCellDelegate {
    func onValueChanged(isOn: Bool, sourceCell:SwitchCell)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var txtLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    
    var delegate: SwitchCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onValueChanged(sender: UISwitch) {
        if delegate != nil {
            delegate.onValueChanged(sender.on, sourceCell: self)
        }
    }
}
