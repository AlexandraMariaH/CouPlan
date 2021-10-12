//
//  BarButton.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 05.10.21.
//

import UIKit

class BarButton: UIBarButtonItem {
    

        let lightYellow = UIColor(red:0.77, green:0.71, blue:0.56, alpha:1.0)

        let lightRose = UIColor(red:0.86, green:0.48, blue:0.65, alpha:1.0)


     override func awakeFromNib() {
         super.awakeFromNib()
         
         let weWantGirlyMode = UserDefaults.standard.bool(forKey: "girlyModeThemeOn")
         
             if weWantGirlyMode {
                 self.tintColor = lightRose
                 
                 if UIViewController.self != OverviewViewController.self{
                 
                     self.image = UIImage(systemName: "arrow.backward.circle.fill")}

             } else {
                 self.tintColor = lightYellow
                 
                 if UIViewController.self != OverviewViewController.self{
                     
                 self.image = UIImage(systemName: "arrow.backward.circle.fill")
                 }
             }
        
     }
    
}
    
    

