//
//  NormalCell.swift
//  Yelp
//
//  Created by Ledesma Usop Jr. on 7/26/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit



class NormalCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var detailLabel: UILabel!
    
    var delegate:CustomTableCellDelegate!
    var cellDescriptor:[String:String]!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if delegate != nil{
            delegate.onSelectedCell(selected, source: self, descriptor: cellDescriptor)
        }
    }

}
