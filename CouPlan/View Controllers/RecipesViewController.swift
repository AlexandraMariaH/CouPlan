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
    
   // let allRecipes = Recipe.allRecipes
    
    var recipes: [Recipe]?

    
   // let allRecipes = RecipeResponse.allRecipes

    
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
        
        print("fetchedResultController", fetchedResultsController)
        let recipeObject = fetchedResultsController.object(at: indexPath)
        print("recipeObject", recipeObject)
        print("recipeObjectUURL", recipeObject.url)

        if (recipeObject == nil) {
         self.showAlert(message: "")
         }
        
        API.requestImageFile(url: URL(string: recipeObject.url!)!) { data, error in
            
            print("URLL", recipeObject.url)
            
            print("CELLdata", data)

            
            recipeObject.recipe = data
            
            self.dataController.save()
            DispatchQueue.main.async {
                cell.recipeImageView.image = UIImage(data: recipeObject.recipe!)
                
                cell.recipeLabel.text = recipeObject.label
                
                print("CELL", recipeObject.recipe?.first)
                print("CELL1", UIImage(data: recipeObject.recipe!))
                print("CELL12", recipeObject.recipe)


                print("CELL2", cell.recipeImageView.image)

            }
        }
        return cell
    }
    
    // MARK: Items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects!.count
    }
    
    // MARK: Show details of one Recipe
  /*  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        performSegue(withIdentifier: "showRecipeDetails", sender: (Any).self)
    }*/
    
   /* func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
    /*    let detailController = self.storyboard!.instantiateViewController(withIdentifier: "RecipeDetailViewController") as! RecipeDetailsViewController
        detailController.recipe = self.recipes?[(indexPath as NSIndexPath).row]
        self.viewController!.pushViewController(detailController, animated: true)
                                                                                                  
    }*/
        let recipeObject = fetchedResultsController.object(at: indexPath)

        do {
          //  recipes = try dataController.viewContext.fetch(Recipe.fetchRequest())
           // var recipes = [recipeObject]

        
            print("recipesTEST", recipeObject.url)
     //       print("recipesTEST", recipes)

            
    } catch {
        debugPrint("fetching pin was not successfull")
    }
        
        if let detailController = self.storyboard!.instantiateViewController(withIdentifier: "RecipeDetailViewController") as? RecipeDetailsViewController {
            //for recipe in recipes! {
                    //if let indexPathOfTappedRecipe = recipes?.firstIndex(of: recipe){
                        
                       // detailController.recipe = recipes?[indexPathOfTappedRecipe]
            detailController.recipe = recipeObject
            detailController.dataController = dataController
                        
                        print("detailTEST", detailController.recipe)

              //      }
                    
                //}
            }
        }
        
      /*  let detailController = self.storyboard!.instantiateViewController(withIdentifier: "RecipeDetailViewController") as! RecipeDetailsViewController
        
        
        detailController.recipe = recipes?[(indexPath as NSIndexPath).row]
        
    //    detailController.recipe = self.recipe
        
     //   self.viewContr!.pushViewController(detailController, animated: true)
        
        detailController.dataController = dataController

        performSegue(withIdentifier: "showRecipeDetails", sender: (Any).self)*/
//
    */
    
}
