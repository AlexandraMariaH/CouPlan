//
//  ViewController.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 18.09.21.
//

import UIKit

class SettingsViewController: UIViewController {

    /// The view for the settings
    @IBOutlet var viewSettings: UIView!
    
    /// A control button that enables to switch between two modes
    @IBOutlet weak var modeSwitch: UISwitch!
    
    @IBOutlet weak var button: UIBarButtonItem!
    
    let lightYellow = UIColor(red:0.95, green:0.89, blue:0.77, alpha:1.0)
    let lightRose = UIColor(red:0.91, green:0.75, blue:0.84, alpha:1.0)
    
    let rose = UIColor(red:0.86, green:0.48, blue:0.65, alpha:1.0)
    
    let yellow = UIColor(red:0.77, green:0.71, blue:0.56, alpha:1.0)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weWantGirlyMode = UserDefaults.standard.bool(forKey: "girlyModeThemeOn")
        
            if weWantGirlyMode {
                switchToGirlyMode()
                print("we like girlyMode")
                viewSettings.backgroundColor = lightRose
                button.tintColor = rose
                

            } else {
                print("we like borringMode")
                viewSettings.backgroundColor = lightYellow
                button.tintColor = yellow


            }
    }
    
    @IBAction func switchMode(_ sender: Any) {
        if modeSwitch.isOn {
            switchToGirlyMode()
            UserDefaults.standard.set(true, forKey: "girlyModeThemeOn")
        } else {
            switchToBorringMode()
            UserDefaults.standard.set(false, forKey: "girlyModeThemeOn")
        }
    }
    
   
    func switchToGirlyMode() {
        print("switched to girlyMode preferences")
        viewSettings.backgroundColor = lightRose
        button.tintColor = rose

    }
    
    func switchToBorringMode() {
        print("switched to borringMode preferences")
        viewSettings.backgroundColor = lightYellow
        button.tintColor = yellow


    }


}

