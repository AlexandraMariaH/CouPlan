//
//  RecipesViewController.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 08.10.21.
//

/*import UIKit
import CoreData

class RecipesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
    
    
    
    /// A collection view that displays a collection of recipes from Instagram
    @IBOutlet weak var collectionView: UICollectionView!
    /// The layout for the collection view
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    //var dataController: DataController! = (UIApplication.shared.delegate as! AppDelegate).dataController
   // var dataController: DataController!
    
 //   var fetchedResultsController: NSFetchedResultsController<Recipe>!
    
    var recipes: [Recipe]?
        
 /*   fileprivate func setupFetchedResultsController() {
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
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // MARK: Float layout of the collection view
      //  let space:CGFloat = 3.0
     //   let dimension = (view.frame.size.width - (2 * space)) / 3.0

     //   collectionViewFlowLayout.minimumInteritemSpacing = space
     //   collectionViewFlowLayout.minimumLineSpacing = space
    //    collectionViewFlowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        // MARK: download recipes
     /*   if pin.recipes?.count == 0 {
            downloadPictures(page: 1, completion: {
                self.collectionView.reloadData()
            })
        }*/
        
      //  setupFetchedResultsController()
        
     //   showRecipes()
    
       // Client.requestRecipesList(completionHandler: handleRecipesListResponse(recipes:error:))
    }
    
   /* func showRecipes() {
        fetchRecipeFromDataController()
        
    }*/
    
   /* func handleRecipesListResponse(recipes: [String], error: Error?) {
        self.recipes = recipes
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func handleRecipeResponse(imageData: RecipeImage?, error: Error?) {
        guard let imageURL = URL(string: imageData?.message ?? "") else {
            return
        }
        Client.requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:error:))
    }

    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.collectionView.image = image
        }
    }*/

    
  /*  fileprivate func fetchRecipeFromDataController() {
        do {
            recipes = try dataController.viewContext.fetch(Recipe.fetchRequest())
        } catch {
            debugPrint("fetching recipe was not successfull")
        }
    }*/

    
    // MARK: Cell for item at index path
   /* func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipesCell", for: indexPath) as! RecipesCell
      //  let recipeObject = fetchedResultsController.object(at: indexPath)
                
        // Set the recipe
      /*  API.taskForDownloadImage(url: URL(string: recipeObject.url!)!) { data, error in
            
            recipeObject.recipe = data
                    
            self.dataController.save()
            DispatchQueue.main.async {
                cell.recipeImageView.image = UIImage(data: recipeObject.recipe!)
            }
        }*/

        return cell
    }*/
    
    func handleRandomImageResponse(imageData: RecipeImage?, error: Error?) {
        guard let imageURL = URL(string: imageData?.message ?? "") else {
            return
        }
        API.requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:error:))
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      //  DispatchQueue.main.async {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipesCell", for: indexPath) as! RecipesCell
        
        // Set the photo
        
        handleRandomImageResponse()
            
            cell.recipeImageView.image = recipe

        }
            //self.imageView.image = image
        
        return cell
        //}
    }
    
    // MARK: Items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return fetchedResultsController.fetchedObjects!.count
        return 1
    }
    
  /*  fileprivate func fetchRecipeFromDataController() {
        do {
            recipes = try dataController.viewContext.fetch(Recipe.fetchRequest())
        } catch {
            debugPrint("fetching recipe was not successfull")
        }
    }*/
    
    
}*/
