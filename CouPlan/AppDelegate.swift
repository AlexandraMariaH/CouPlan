//
//  AppDelegate.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 18.09.21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let dataController = DataController(modelName: "CouPlan")


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        dataController.load()
        
        return true
    }


}

