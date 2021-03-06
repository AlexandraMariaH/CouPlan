//
//  ItemsListViewController.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 27.09.21.
//

import UIKit
import CoreData
import Foundation

class ItemsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /// A table view that displays a list of items for a shoppinglist
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    var rowsWhichAreChecked = [NSIndexPath]()
    
    /// The shoppinglist whose items are being displayed
    var shoppinglist: Shoppinglist!
    
    var dataController: DataController! = (UIApplication.shared.delegate as! AppDelegate).dataController
    
    var fetchedResultsController:NSFetchedResultsController<Item>!

    fileprivate func setupFetchedResultsController() {
        let fetchRequest:NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "shoppinglist == %@", shoppinglist)
        fetchRequest.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "\(shoppinglist!)-items")
        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
          
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsMultipleSelection = true
        navBar.topItem?.title = shoppinglist.name
        setupFetchedResultsController()
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

    // ---------------------------------------------------------------------
    // MARK: - Actions

    @IBAction func addItem(_ sender: Any) {
        presentNewItemAlert()
    }
    
    // ---------------------------------------------------------------------
    // MARK: - Editing
    
    /// Display an alert prompting the user to name a new Shopping List. Calls
    /// `addShoppingList(name:)`.
    func presentNewItemAlert() {
        let alert = UIAlertController(title: "New Item", message: "Enter a name for this Item", preferredStyle: .alert)

        // Create actions
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] action in
            if let name = alert.textFields?.first?.text {
                self?.addItem(name: NSMutableAttributedString(string: name))
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

    // Adds a new `Item` to the end of the `shoppinglist`'s `Items` array
    func addItem(name: NSAttributedString) {
        let item = Item(context: dataController.viewContext)
        item.creationDate = Date()
        item.shoppinglist = shoppinglist
        item.attributedText = name
        try? dataController.viewContext.save()
    }

    // Deletes the `Item` at the specified index path
    func deleteItem(at indexPath: IndexPath) {
        let itemToDelete = fetchedResultsController.object(at: indexPath)
        dataController.viewContext.delete(itemToDelete)
        try? dataController.viewContext.save()
    }

    // -------------------------------------------------------------------------
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let anItem = fetchedResultsController.object(at: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.defaultReuseIdentifier, for: indexPath) as! ItemCell

        // Configure cell
        cell.textPreviewLabel.attributedText = anItem.attributedText
        
        let isRowChecked = rowsWhichAreChecked.contains(indexPath as NSIndexPath)
        if (isRowChecked == true) {
            cell.checkBoxButton.isChecked = true
            cell.checkBoxButton.buttonClicked(sender: cell.checkBoxButton)
        } else {
            cell.checkBoxButton.isChecked = false
            cell.checkBoxButton.buttonClicked(sender: cell.checkBoxButton)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[0].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.00
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: deleteItem(at: indexPath)
        default: () // Unsupported
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemCell = tableView.cellForRow(at: indexPath as IndexPath) as! ItemCell
        itemCell.contentView.backgroundColor = UIColor.white
        if (rowsWhichAreChecked.contains(indexPath as NSIndexPath) == false){
            itemCell.checkBoxButton.isChecked = true
            itemCell.checkBoxButton.buttonClicked(sender: itemCell.checkBoxButton)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let itemCell = tableView.cellForRow(at: indexPath as IndexPath) as! ItemCell
        itemCell.checkBoxButton.isChecked = false
        itemCell.checkBoxButton.buttonClicked(sender: itemCell.checkBoxButton)
        if let checkedItemIndex = rowsWhichAreChecked.firstIndex(of: indexPath as NSIndexPath){
            rowsWhichAreChecked.remove(at: checkedItemIndex)
        }
    }

}

extension ItemsListViewController:NSFetchedResultsControllerDelegate {
    
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
        @unknown default:
            fatalError()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert: tableView.insertSections(indexSet, with: .fade)
        case .delete: tableView.deleteSections(indexSet, with: .fade)
        case .update, .move:
            fatalError("Invalid change type in controller(_:didChange:atSectionIndex:for:). Only .insert or .delete should be possible.")
        @unknown default:
            fatalError()
        }
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}
