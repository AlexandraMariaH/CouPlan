//
//  RecipesViewController.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 08.10.21.
//

import UIKit
import CoreData

class RecipesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
    
    /// A collection view that displays a collection of recipes from Instagram
    @IBOutlet weak var collectionView: UICollectionView!
    /// The layout for the collection view
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    
    // MARK: Variables
    /// The data controller is responsible for establishing a connection with data
    var dataController: DataController!
    var fetchedResultsController: NSFetchedResultsController<Recipe>!
    var recipe: Recipe!
    
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
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // MARK: Float layout of the collection view
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        collectionViewFlowLayout.minimumInteritemSpacing = space
        collectionViewFlowLayout.minimumLineSpacing = space
        collectionViewFlowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        downloadRecipes(completion: {
            self.collectionView.reloadData()
        })
        
        setupFetchedResultsController()
    }
    
    func downloadRecipes(completion: @escaping () -> Void) {
        
        API.downloadRecipe() {
            data,error in
            
            /*  if (data == nil) {
             self.showAlert(message: "")
             }*/
            print("DATAA", data)
            for recipe in recipe? {

            let photoURL = API.getPhotoURL()
            let recipe = Recipe(context: self.dataController.viewContext)
            recipe.url = photoURL
            
            self.dataController.save()
            }
            
            self.setupFetchedResultsController()
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    func showAlert(message: String) {
        let alertVC = UIAlertController(title: "No Recipes", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated:true)
    }
    
    // MARK: Cell for item at index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipesCell", for: indexPath) as! RecipesCell
        
      //  print("fetchedResultController", fetchedResultsController)
        let recipeObject = fetchedResultsController.object(at: indexPath)
      //  print("recipeObject", recipeObject)
        
        API.requestImageFile(url: URL(string: recipeObject.url!)!) { data, error in
            
         //   print("URLL", recipeObject.url)
            
            recipeObject.recipe = data
            
            self.dataController.save()
            DispatchQueue.main.async {
                cell.recipeImageView.image = UIImage(data: recipeObject.recipe!)
                
                print("CELL", recipeObject.recipe)
            }
        }
        return cell
    }
    
    // MARK: Items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects!.count
    }
    
    // MARK: Show details of one Recipe
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        performSegue(withIdentifier: "showRecipeDetails", sender: (Any).self)
    }
    
}
