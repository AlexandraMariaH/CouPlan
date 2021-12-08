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
        
       // test()
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
    
 /*   func test() {
        
        
        let recipeLabeltest =
"""

HEALTHIER THAI GREEN CURRY (vegan) // One of my dinners every week and a favourite for my @mbodycoaching clients because it’s quick, delicious and family-friendly. One of my biggest issues when I started my fitness journey was having to cook separate meals for myself and my family and I wanted to make sure my clients don’t have to do that because let’s face it, who has the time after a long day at work?! \nThis is 38g of vegan protein but you can use whatever protein you like! 🔥\n\nRecipe:\nFor the green curry paste (or can use shop bought paste):\n1/2 shallot\n1 garlic clove\n1/4 thumb-size piece of ginger\n1/2 stalk of lemongrass, soft inner part chopped roughly\n1 kaffir lime leaf (remove centre stalk and crush)\n1 green Thai chilli (deseed for less heat)\n1/4 tsp ground coriander\n1/4 tsp ground cumin\ncoriander stalks & a few leaves coriander\n1/8-1/4 tsp fine sea salt\n35g Jasmine or basmati rice, uncooked\n\nFor the curry:\n85ml light coconut milk\n40g green pepper, diced\n80g tenderstem broccoli, chopped\n45g mushrooms, sliced \n150g vegan chick’n pieces @vivera_uk\n40ml vegetable stock \n1-2 tsp light soy sauce\nFew thai basil leaves (can use regular basil)\ngreen chilli, sliced \n\nMethod:\n1. Cook the rice according to the packaging instructions and leave to drain.\n2. Blend the paste ingredients in a blender or food processor.\n3. Chop the vegetables into small pieces.\n4. In a wok or large frying pan, heat one cal oil spray and add in the green curry paste along with 1-2 tsp of the coconut milk and stir until the aromas release. \n5. Next, pour in the coconut milk and let it come to a gentle bubble.\n6. Add the chopped vegetables and cook for 2-3 minutes on a medium heat. \n7. Add in the chick\'n pieces, soy sauce and vegetable stock. Turn the heat down to a simmer and cook, covered, for about 3-4 minutes.\n8. Add a good handful thai basil leaves, but only leave them briefly on the heat or they will quickly lose their brightness.\n9. Serve immediately with boiled rice. Top with sliced green chilli (optional).\n\n✨ to enjoy family friendly meals like this and achieve your fitness goals, enquire about coaching with @mbodycoaching, link in bio\n✨ Macros: 515 cals | P38g | F28g | C48g
"""
        
        let recipeLabelFormatted = recipeLabelFormatting(recipeUnformatted: recipeLabeltest)
        
        func recipeLabelFormatting(recipeUnformatted: String) -> String {
            let recipeLabelSeperated = recipeUnformatted.components(separatedBy: " ")
                        
            var upperCaseWords: Array<String> = []
            for word in recipeLabelSeperated {
                if word == word.uppercased() && word.count > 1 && word != word.lowercased() {
                    upperCaseWords.append(word)
                }
            }
            
            var recipeLabelFormatted: String = ""
            for words in upperCaseWords {
                recipeLabelFormatted.append(words)
                recipeLabelFormatted.append(" ")
            }
                        
            return recipeLabelFormatted
        }

       let recipeInstructionsFormatted = recipeInstructionsFormatting(recipeUnformatted: recipeLabeltest)
        
        func recipeInstructionsFormatting(recipeUnformatted: String) -> String {
            
        let recipeSeperated = recipeUnformatted.components(separatedBy: "Recipe")[1]
        let recipeCuttedEnd = recipeSeperated.components(separatedBy: "✨")[0]
            
            return recipeCuttedEnd
        }
        
        
        print("RESULT2", recipeLabelFormatted, recipeInstructionsFormatted)

    }*/
    
}

