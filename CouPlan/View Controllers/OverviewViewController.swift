//
//  ViewController.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 18.09.21.
//

import UIKit

class OverviewViewController: UIViewController {
    
    @IBOutlet weak var overViewNavigationBar: UINavigationBar!
  
    override func viewDidLoad() {
           super.viewDidLoad()
       }
    
    // MARK: Segue with Code Approach

    @IBAction private func goToShoppingList(_ sender: UIButton) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ShoppingListViewController") as! ShoppingListViewController
       // vc.userChoice = getUserShape(sender)
        present(viewController, animated: true, completion: nil)
  
        performSegue(withIdentifier: "goToShoppingList", sender: sender)
    }



   
}

