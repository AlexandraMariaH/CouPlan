//
//  OneRecipeViewController.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 03.12.21.
//

import UIKit
import CoreData

class OneRecipeViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: Variables
    /// The data controller is responsible for establishing a connection with data
    var dataController: DataController!
    var fetchedResultsController: NSFetchedResultsController<Recipe>!
    var recipe: Recipe!
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeInstructions: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate func setupFetchedResultsController() {
        dataController = (UIApplication.shared.delegate as! AppDelegate).dataController
        
        let fetchRequest:NSFetchRequest<Recipe> = Recipe.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "url", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "recipes")
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.topItem?.title = "Recipe of the day"

        downloadRecipes(completion: {
        })
        
        setupFetchedResultsController()
        
     //   translatesAutoresizingMaskIntoConstraints = false
        
      /*  let constraints = [
            view.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
            view.widthAnchor.constraint(equalToConstant: 100),
            view.heightAnchor.constraint(equalTo: view.widthAnchor)
        ]*/
        
      //  NSLayoutConstraint.activate(constraints)
    }
    
    func downloadRecipes(completion: @escaping () -> Void) {
        setWaitingForAPI(true)
        
        API.downloadRecipe() {
            data,error in
            
            if (data == nil) {
                self.setWaitingForAPI(false)

                print("teeeest")
                self.showMessage(message: "")
                
            }
            
            if (data != nil) {
            let photoURL = data?.body.edges.first?.node.display_url
            let label = data?.body.edges.first?.node.edge_media_to_caption.edges.first?.node.text
            
            let recipe = Recipe(context: self.dataController.viewContext)
            recipe.url = photoURL
            recipe.label = label
            
            let recipeLabelFormatted = self.recipeLabelFormatting(recipeUnformatted: recipe.label!)
            
            self.recipeLabel.text = recipeLabelFormatted
            
            let recipeInstructionsFormatted = self.recipeInstructionsFormatting(recipeUnformatted: recipe.label!)
            
            self.recipeInstructions.text = "Recipe" + recipeInstructionsFormatted

            self.dataController.save()
            self.setupFetchedResultsController()
            print("AArecipe", self.recipeLabel.text, recipe.url, self.recipeInstructions.text)
            
            guard let imageURL = URL(string: data?.body.edges.first?.node.display_url ?? "") else {
                return
            }
            
            API.requestImage(url: imageURL, completionHandler: self.showImage(image:error:))
            }
            
        }
    }
    
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
    
    func recipeInstructionsFormatting(recipeUnformatted: String) -> String {
        
    let recipeSeperated = recipeUnformatted.components(separatedBy: "Recipe")[1]
    let recipeInstructionsFormatted = recipeSeperated.components(separatedBy: "✨")[0]
        
        return recipeInstructionsFormatted
    }
    
    func showImage(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.setWaitingForAPI(false)

            self.recipeImageView.image = image
        }
    }
    
    func setWaitingForAPI(_ waiting: Bool) {
        if waiting {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        recipeLabel.isHidden = waiting
        recipeInstructions.isHidden = waiting
    }
    
  /*  func showAlert(message: String) {
        print("teeeeeest")
        let alertVC = UIAlertController(title: "No Recipes", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated:true)
    }*/
    
    func showMessage(message: String) {
        let alertVC = UIAlertController(title: "No Recipes", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in
            DispatchQueue.main.async {
               // self.performSegue(withIdentifier: "unwindToLogin", sender: (Any).self)
                self.dismissVC((Any).self)
            }
        }))
        self.present(alertVC, animated:true)
    }
    
    @IBAction func dismissVC(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
    
}
