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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weWantGirlyMode = UserDefaults.standard.bool(forKey: "girlyModeThemeOn")
        
            if weWantGirlyMode {
                switchToGirlyMode()
                print("we like girlyMode")
                viewSettings.backgroundColor = UIColor.systemPink

            } else {
                print("we like borringMode")
                viewSettings.backgroundColor = UIColor.yellow

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
        viewSettings.backgroundColor = UIColor.systemPink
    }
    
    func switchToBorringMode() {
        print("switched to borringMode preferences")
        viewSettings.backgroundColor = UIColor.yellow

    }


}

