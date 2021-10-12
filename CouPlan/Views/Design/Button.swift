//
//  Button.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 04.10.21.
//

import UIKit

class Button: UIButton {
    
    let lightRose = UIColor(red:0.91, green:0.75, blue:0.84, alpha:1.0)
   let lila = UIColor(red:0.71, green:0.65, blue:0.73, alpha:1.0)


    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 10
        tintColor = UIColor.black
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        backgroundColor = lila
    
    
       
    
}
    
}
