//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Bijan Fazeli on 6/19/18.
//  Copyright © 2018 Fazeli, Bijan. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryTableViewController: UITableViewController {

    let realm = try! Realm()
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(realm.configuration.fileURL!)
        
        loadCategories()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories?[indexPath.row]
        
        cell.textLabel?.text = category?.name ?? "No categories added yet"
        
        return cell
    }
    
    // MARK: - Table view delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
    
    
    // MARK: - DATA Manipulation
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    func save(object category : Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context: \(error)")
        }
        tableView.reloadData()
    }
    
    
    // MARK: - Adding Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textInput = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter a category.."
            textInput = textField
        }
        
        let addCategory = UIAlertAction(title: "Add", style: .default) { (_) in
            let newCategory = Category()
            newCategory.name = textInput.text!
            
            self.save(object: newCategory)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addCategory)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}
