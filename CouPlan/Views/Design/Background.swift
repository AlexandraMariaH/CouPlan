//
//  Background.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 05.10.21.
//

import UIKit

class Background: UIView {

    
   let lightYellow = UIColor(red:0.95, green:0.89, blue:0.77, alpha:1.0)
   let lightRose = UIColor(red:0.91, green:0.75, blue:0.84, alpha:1.0)

override func awakeFromNib() {
    super.awakeFromNib()
    
    let weWantGirlyMode = UserDefaults.standard.bool(forKey: "girlyModeThemeOn")
    
        if weWantGirlyMode {
            backgroundColor = lightRose

        } else {
            backgroundColor = lightYellow
        }
   
}
    
}
