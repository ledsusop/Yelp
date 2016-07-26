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
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
