//
//  CheckBoxButton.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 15.11.21.
//

import Foundation
import UIKit

class CheckBoxButton : UIButton {
    let checkedimage = UIImage(named: "CheckBoxButtonChecked")! as UIImage
    let uncheckedImage = UIImage(named: "CheckBoxButtonUnchecked")! as UIImage
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(uncheckedImage, for: .normal)
            } else {
                self.setImage(checkedimage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.setTitle("", for: .normal)
        self.isUserInteractionEnabled = true
        self.addTarget(self, action: #selector(CheckBoxButton.buttonClicked), for: .touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self{
            if isChecked == true {
                isChecked = false
            } else {
                isChecked = true
            }
        }
    }
    
}
