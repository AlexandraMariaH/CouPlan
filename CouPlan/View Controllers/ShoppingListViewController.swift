//
//  ShoppingListViewController.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 25.09.21.
//

import UIKit
import CoreData

class ShoppingListViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var back: UIBarButtonItem!
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    /// A table view that displays a list of shopping lists
    @IBOutlet weak var tableView: UITableView!
    
    var dataController: DataController! = (UIApplication.shared.delegate as! AppDelegate).dataController

    var fetchedResultsController:NSFetchedResultsController<Shoppinglist>!
    
    fileprivate func setupFetchedResultsController() {
        let fetchRequest:NSFetchRequest<Shoppinglist> = Shoppinglist.fetchRequest()
     
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        print("test", dataController.viewContext)
        
       // print("TEST22", fetchedResultsController!.fetchedObjects?.count)
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "shoppinglists")
        
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFetchedResultsController()
        
        let weWantGirlyMode = UserDefaults.standard.bool(forKey: "girlyModeThemeOn")
        
            if weWantGirlyMode {
                navBar.barTintColor = UIColor.systemPink
                toolBar.barTintColor = UIColor.systemPink
            } else {
                navBar.barTintColor = UIColor.yellow
                toolBar.barTintColor = UIColor.yellow
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchedResultsController()
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedResultsController = nil
    }
    
    // ----------------------------------------------------------------------
    // MARK: - Actions

    @IBAction func addShoppingList(_ sender: Any) {
        presentNewShoppingListAlert()
    }

    // -----------------------------------------------------------------------
    // MARK: - Editing
    
    /// Display an alert prompting the user to name a new Shopping List. Calls
    /// `addShoppingList(name:)`.
    func presentNewShoppingListAlert() {
        let alert = UIAlertController(title: "New ShoppingList", message: "Enter a name for this ShoppingList", preferredStyle: .alert)

        // Create actions
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] action in
            if let name = alert.textFields?.first?.text {
                self?.addShoppingList(name: name)
            }
        }
        saveAction.isEnabled = false

        // Add a text field
        alert.addTextField { textField in
            textField.placeholder = "Name"
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: .main) { notif in
                if let text = textField.text, !text.isEmpty {
                    saveAction.isEnabled = true
                } else {
                    saveAction.isEnabled = false
                }
            }
        }

        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }

    /// Adds a new shoppingList to the end of the `shoppinglists` array
    func addShoppingList(name: String) {
        let shoppingList = Shoppinglist(context: dataController.viewContext)
        shoppingList.name = name
        shoppingList.creationDate = Date()
        try? dataController.viewContext.save()
    }

    /// Deletes the shoppingList at the specified index path
    func deleteShoppingList(at indexPath: IndexPath) {
        let shoppingListToDelete = fetchedResultsController.object(at: indexPath)
        dataController.viewContext.delete(shoppingListToDelete)
        try? dataController.viewContext.save()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If this is a ItemsListViewController, we'll configure its `Shoppinglist`
        if let itemsListViewController = segue.destination as? ItemsListViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                itemsListViewController.shoppinglist = fetchedResultsController.object(at: indexPath)
                
                print("VCSHOPPINGLIST", itemsListViewController.shoppinglist)
                
                itemsListViewController.dataController = dataController
            }
        }
    }
    
    // ---------------------------------------------------------------------
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aShoppinglist = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: ShoppinglistCell.defaultReuseIdentifier, for: indexPath) as! ShoppinglistCell

        // Configure cell
        cell.nameLabel.text = aShoppinglist.name
            
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: deleteShoppingList(at: indexPath)
        default: () // Unsupported
        }
    }

}

extension ShoppingListViewController:NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
            break
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            break
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert: tableView.insertSections(indexSet, with: .fade)
        case .delete: tableView.deleteSections(indexSet, with: .fade)
        case .update, .move:
            fatalError("Invalid change type in controller(_:didChange:atSectionIndex:for:). Only .insert or .delete should be possible.")
        }
    }

    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}
