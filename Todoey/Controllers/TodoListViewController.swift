//
//  ViewController.swift
//  Todoey
//
//  Created by Bijan Fazeli on 6/5/18.
//  Copyright © 2018 Fazeli, Bijan. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    let realm = try! Realm()
    
    var todoItems : Results<Item>!
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = "Search.."
        
       loadItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No items added"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
                tableView.cellForRow(at: indexPath)?.accessoryType = item.done ? .checkmark : .none
            }
            catch {
                print("Error trying to update")
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    // MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textInput = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What happens when user clicks Add Item
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textInput.text!
                        newItem.date = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error trying to save \(error)")
                }
            }
            
           
            
            self.tableView.reloadData()
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Create new item"
            textInput = textField
        }
        
        alert.addAction(action)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//        do {
//            sports = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
        
        tableView.reloadData()
    }
}

extension TodoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date", ascending: true)
        
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
            
            
            // self.view.endEditing(true)
        }
    }
}

