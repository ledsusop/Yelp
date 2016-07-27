//
//  BusinessCell.swift
//  Yelp
//
//  Created by Ledesma Usop Jr. on 7/22/16.
//  Copyright © 2016 Ledesma Usop Jr. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var ratingsImageView: UIImageView!
    
    var rowIndex : Int = 0
    
    var business : Business! {
        didSet {
            self.populateFields()
        }
    }
    
    internal func populateFields() {
        if business != nil {
            nameLabel.text = String(rowIndex)+". "+business.name!
            addressLabel.text = business.address
            categoriesLabel.text = business.categories
            distanceLabel.text = business.distance
            self.setImageURL(thumbImageView, nsURL: business.imageURL)
            self.setImageURL(ratingsImageView, nsURL: business.ratingImageURL)
        }
    }
    
    internal func setImageURL(imageView:UIImageView, nsURL: NSURL?){
        if nsURL != nil {
        let imageRequest = NSURLRequest(URL: nsURL!)
            imageView.setImageWithURLRequest(
                imageRequest,
                placeholderImage: nil,
                success: { (imageRequest, imageResponse, image) -> Void in
                    
                    // imageResponse will be nil if the image is cached
                    if imageResponse != nil {
                        imageView.alpha = 0.0
                        imageView.image = image
                        UIView.animateWithDuration(0.3, animations: { () -> Void in
                            imageView.alpha = 1.0
                        })
                    } else {
                        imageView.image = image
                    }
                },
                failure: { (imageRequest, imageResponse, error) -> Void in
                    // do something for the failure condition
            })
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbImageView.layer.cornerRadius = 5
        thumbImageView.clipsToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
