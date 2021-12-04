//
//  OneRecipeViewController.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 03.12.21.
//

import UIKit
import CoreData

/*class OneRecipeViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: Variables
    /// The data controller is responsible for establishing a connection with data
    var dataController: DataController!
    var fetchedResultsController: NSFetchedResultsController<Recipe>!
    var recipe: Recipe!
    
    var recipeImageView: UIImageView
    var recipeLabel: UILabel
            
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
        
        downloadRecipes(completion: {
            self.imageView()
        })
        
        setupFetchedResultsController()
    }
    
    func downloadRecipes(completion: @escaping () -> Void) {
        
        API.downloadRecipe() {
            data,error in
            
            if (data == nil) {
             self.showAlert(message: "")
             }
    
            print("PHOTOurl", API.getPhotoURL())
            
            let photoURL = data?.body.edges.first?.node.display_url
            
            print("testURL", data?.body.edges.first?.node.display_url)
            print("testURL2", data?.body.edges)
            print("testURL3", data?.body.edges.first)
            print("testURL3.3", data?.body.edges.last)

            print("testURL4", data?.body.edges.count)


            
            print("testTEXT", data?.body.edges.first?.node.edge_media_to_caption.edges.first?.node.text)

            let recipeLabel = data?.body.edges.first?.node.edge_media_to_caption.edges.first?.node.text
            
            let recipe = Recipe(context: self.dataController.viewContext)
            recipe.url = photoURL
            recipe.label = recipeLabel
            
            self.dataController.save()
            
            self.setupFetchedResultsController()
            
        }
    }
    
    func showAlert(message: String) {
        let alertVC = UIAlertController(title: "No Recipes", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated:true)
    }
    

        
        let recipeObject = fetchedResultsController.object(at: indexPath)
       
        if (recipeObject == nil) {
         self.showAlert(message: "")
         }
        
        API.requestImageFile(url: URL(string: recipeObject.url!)!) { data, error in
            
            recipeObject.recipe = data
            
            self.dataController.save()
            DispatchQueue.main.async {
                recipeImageView.image = UIImage(data: recipeObject.recipe!)
                
                recipeLabel.text = recipeObject.label
                
            }
        }
    }
                                                                                    
    
}*/
