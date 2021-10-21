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
    
    //var dataController: DataController! = (UIApplication.shared.delegate as! AppDelegate).dataController
    // MARK: Variables
    /// The data controller is responsible for establishing a connection with data
    var dataController: DataController!
    
    var fetchedResultsController: NSFetchedResultsController<Recipe>!
    
    var recipe: Recipe!
        
    fileprivate func setupFetchedResultsController() {
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
        
        downloadRecipes(completion: {
            self.collectionView.reloadData()
        })
        
        setupFetchedResultsController()
    }
    
    func downloadRecipes(completion: @escaping () -> Void) {
        print("HEEEERE")
     //   DispatchQueue.main.async {
            print("HEEEERE2")
            //API.downloadRecipes() { data,error in
        
        API.downloadRecipes() { recipes,error in
            
            print("HERE16", recipes?.photo_url)

                
             /*   print("DATA", data, data?.display_url)
                
                if (data?.display_url == nil) {
                    self.showAlert(message: "")
                }
                
                    let recipe = Recipe(context: self.dataController.viewContext)
                    recipe.url = data!.display_url
                    
                    self.dataController.save()
                
                self.setupFetchedResultsController()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }*/
            }
       // }
    }
    
    func showAlert(message: String) {
        let alertVC = UIAlertController(title: "No Recipes", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated:true)
    }
    
        
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
   // }
    
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
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipesCell", for: indexPath) as! RecipesCell
        
        print("fetchedResultController", fetchedResultsController)
        let recipeObject = fetchedResultsController.object(at: indexPath)
        print("recipeObject", recipeObject)

        // Set the recipe
      /*  API.taskForDownloadImage(url: URL(string: recipeObject.url!)!) { data, error in
            
            recipeObject.recipe = data
                    
            self.dataController.save()
            DispatchQueue.main.async {
                cell.recipeImageView.image = UIImage(data: recipeObject.recipe!)
            }
        }*/
        return cell
    }
    
    func handleRandomImageResponse(imageData: RecipeImage?, error: Error?) {
     /*   guard let imageURL = URL(string: imageData?.message ?? "") else {
            return
        }*/
      //  API.requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:error:))
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
          //  self.imageView.image = image
        }
    }
    
   /* func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      //  DispatchQueue.main.async {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipesCell", for: indexPath) as! RecipesCell
        
        // Set the photo
        
       // handleRandomImageResponse()
            
          //  cell.recipeImageView.image = recipe

        
            //self.imageView.image = image
        
        return cell
        //}
    }*/
    
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
    
    // MARK: Show details of one Recipe
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
    //    let detailController = self.storyboard!.instantiateViewController(withIdentifier: "OneRecipeViewController") as! OneRecipeViewController
      //  detailController.recipe = self.recipes[(indexPath as NSIndexPath).row]
      //  navigationController!.pushViewController(detailController, animated: true)
         performSegue(withIdentifier: "showRecipeDetails", sender: (Any).self)

     }
    
    
}
