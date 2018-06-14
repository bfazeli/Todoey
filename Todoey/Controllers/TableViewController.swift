//
//  ViewController.swift
//  Todoey
//
//  Created by Bijan Fazeli on 6/5/18.
//  Copyright © 2018 Fazeli, Bijan. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var sports = [Sport]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Sports.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(dataFilePath!)
        
        // Do any additional setup after loading the view, typically from a nib.
//        if let items = userDefaults.array(forKey: "SportsArray") as? [String] {
//            sports = items
//        }
        
        loadItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        
        let sport = sports[indexPath.row]
        
        cell.textLabel?.text = "I play " + sport.getTitle()
        cell.accessoryType = sport.isChecked() ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sport = sports[indexPath.row]
        
        tableView.cellForRow(at: indexPath)?.accessoryType = sport.isChecked() ? .none : .checkmark
        sport.isChecked(!sport.isChecked())
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textInput = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What happens when user clicks Add Item
            self.sports.append(Sport(title: textInput.text!))
            
           
            self.saveItems()
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Create new item"
            textInput = textField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(sports)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array")
        }
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                sports = try decoder.decode([Sport].self, from: data)
            } catch {
                print("Error decoding items")
            }
        }
    }
}

