//
//  UIHelper.swift
//  Yelpie
//
//  Created by Ledesma Usop Jr. on 7/25/16.
//  Copyright © 2016 Leds Usop. All rights reserved.
//

import UIKit

class UIHelper {
    
    static func getNormalButtonColors() -> [CGColor]{
        return[
            UIColor(red: 0xE1, green: 0x3B, blue: 0x35).CGColor,
            UIColor(red: 0xC4, green: 0x12, blue: 00).CGColor,
            UIColor(red: 0xC4, green: 0x12, blue: 00).CGColor,
            UIColor(red: 0xaa, green: 0x12, blue: 00).CGColor,
        ]
    }
    
    static func getHighlightedColors() -> [CGColor]{
        return[
            UIColor(red: 0xFF, green: 0x5b, blue: 0x65).CGColor,
            UIColor(red: 0xE1, green: 0x3B, blue: 0x35).CGColor,
            UIColor(red: 0xE1, green: 0x3B, blue: 0x35).CGColor,
            UIColor(red: 0xE1, green: 0x3B, blue: 0x35).CGColor,
            UIColor(red: 0xE1, green: 0x3B, blue: 0x35).CGColor,
        ]
    }
    
    static func stylizeButton(btn:UIButton,state:UIControlState){
        
        let barbuttonLayers = btn.layer.sublayers ?? [CALayer]()
        if barbuttonLayers.count > 0{
            btn.frame = CGRectMake(20, 7, 60, 30)
        }else {
            btn.frame = CGRectMake(0, 0, 60, 30)
        }
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = btn.bounds
        gradient.colors = state == UIControlState.Normal ? UIHelper.getNormalButtonColors() : UIHelper.getHighlightedColors()
        gradient.locations = [0, 0.4, 0.6, 1.0]
        gradient.borderWidth = 1
        gradient.borderColor = UIColor(red: 0x88, green: 0x12, blue: 00).CGColor
        gradient.cornerRadius = 4
        
        if barbuttonLayers.count > 0{
            btn.layer.replaceSublayer(barbuttonLayers[0], with: gradient)
        }else {
            btn.layer.insertSublayer(gradient, atIndex: 0)
        }
        
    }
    
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
