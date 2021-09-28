//
//  ItemsListViewController.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 27.09.21.
//

import UIKit
import CoreData

class ItemsListViewController: UIViewController, UITableViewDataSource {
    
    /// A table view that displays a list of items for a shoppinglist
    @IBOutlet weak var tableView: UITableView!
    
    /// The shoppinglist whose items are being displayed
    var shoppinglist: Shoppinglist!
    
    var dataController: DataController! = (UIApplication.shared.delegate as! AppDelegate).dataController
    
    var fetchedResultsController:NSFetchedResultsController<Item>!

    /// A date formatter for date text in item cells
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()

    fileprivate func setupFetchedResultsController() {
        let fetchRequest:NSFetchRequest<Item> = Item.fetchRequest()
        print("SHOPPINGLIST", shoppinglist)
        let predicate = NSPredicate(format: "shoppinglist == %@", shoppinglist)
        fetchRequest.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        print("TEST0", dataController)

        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "\(shoppinglist)-items")
        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("VCSHOPPINGLIST2", shoppinglist)

        navigationItem.title = shoppinglist.name
        navigationItem.rightBarButtonItem = editButtonItem
        
        setupFetchedResultsController()
        
        updateEditButtonState()
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

    @IBAction func addItemTapped(_ sender: Any) {
        addItem()
    }
    
    // ---------------------------------------------------------------------
    // MARK: - Editing

    // Adds a new `Item` to the end of the `shoppinglist`'s `Items` array
    func addItem() {
        
        print("TESTTEST", dataController.viewContext)
        print("TEEEEST",Item(context: dataController.viewContext))
        
        let item = Item(context: dataController.viewContext)
        item.creationDate = Date()
        item.shoppinglist = shoppinglist
        try? dataController.viewContext.save()
    }

    // Deletes the `Item` at the specified index path
    func deleteItem(at indexPath: IndexPath) {
        let itemToDelete = fetchedResultsController.object(at: indexPath)
        dataController.viewContext.delete(itemToDelete)
        try? dataController.viewContext.save()
    }

    func updateEditButtonState() {
       navigationItem.rightBarButtonItem?.isEnabled = fetchedResultsController.sections![0].numberOfObjects > 0
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }

    // -------------------------------------------------------------------------
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[0].numberOfObjects ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let anItem = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.defaultReuseIdentifier, for: indexPath) as! ItemCell

        // Configure cell
        cell.textPreviewLabel.attributedText = anItem.attributedText as! NSAttributedString
        
        /*if let creationDate = anItem.creationDate {
            cell.dateLabel.text = dateFormatter.string(from: creationDate)
        }*/

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: deleteItem(at: indexPath)
        default: () // Unsupported
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Navigation

  /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If this is a ItemDetailsViewController, we'll configure its `Item`
        // and its delete action
        if let vc = segue.destination as? ItemDetailsViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                vc.item = fetchedResultsController.object(at: indexPath)
                vc.dataController = dataController

                vc.onDelete = { [weak self] in
                    if let indexPath = self?.tableView.indexPathForSelectedRow {
                        self?.deleteIem(at: indexPath)
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }*/
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
