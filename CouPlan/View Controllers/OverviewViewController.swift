//
//  ViewController.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 18.09.21.
//

import UIKit
import Firebase

class OverviewViewController: UIViewController {
    
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var overViewNavigationBar: UINavigationBar!
  
    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
           super.viewDidLoad()
    }
    
    // MARK: Segue with Code Approach
    @IBAction private func goToShoppingList(_ sender: UIButton) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ShoppingListViewController") as! ShoppingListViewController
        present(viewController, animated: true, completion: nil)
        performSegue(withIdentifier: "goToShoppingList", sender: sender)
    }
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
    let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        performSegue(withIdentifier: "unwindToLogin", sender: (Any).self)
        
       // self.navigationController?.popToRootViewController(animated: true)
        
        print("INHERE")
        
     /*   guard let user = Auth.auth().currentUser else { return }
        let onlineRef = Database.database().reference(withPath: "online/\(user.uid)")
        onlineRef.removeValue { error, _ in
          if let error = error {
            print("Removing online failed: \(error)")
            return
          }
          do {
            try Auth.auth().signOut()
              
              print("USERLOGGEDIN", user)
              
            self.navigationController?.popToRootViewController(animated: true)
          } catch let error {
            print("Auth sign out failed: \(error)")
          }
        }*/
    }

}

