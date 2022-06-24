//
//  CoreDataTableViewController.swift
//  TodoListViewCode
//
//  Created by user on 24/06/22.
//
import CoreData
import UIKit
import CoreData

class CoreDataTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categories = [NSManagedObject]()
    var model = Model<Category>()
    
    var coreDataView: DataTableView? {
        return view as? DataTableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        navigationItem.title = "Core Data"
        
        coreDataView?.tableView.delegate = self
        coreDataView?.tableView.dataSource = self
        
        categories = model.read()
    
    }
    
    override func loadView() {
        let tableView = DataTableView()
        tableView.setupView()
        tableView.setupConstraints()
        view = tableView
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = categories.count > 0 ? categories.count  : 1
        return count
    }

   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        if categories.count > 0 {
            let category = categories[indexPath.row] as? Category
            cell.textLabel?.text = category?.name
        } else {
            cell.textLabel?.text = "There no Item in the Category List"
        }
       
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
