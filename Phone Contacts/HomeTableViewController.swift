//
//  HomeTableViewController.swift
//  Phone Contacts
//
//  Created by Eang Pheara on 1/4/17.
//  Copyright © 2017 Eang Pheara. All rights reserved.
//

import UIKit
import CoreData

class HomeTableViewController: UITableViewController {
    
    var contacts : [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let contactService = ContactService(context: context)
        
        contacts = contactService.getAll()
        tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.configureCell(contact: (contacts[indexPath.row]))

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }*/


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {        
        if editingStyle == .delete {
            
        } else if editingStyle == .insert {
        
        }
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete  = UITableViewRowAction(style: .default, title: "Delete"){ action ,index in
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let contactService = ContactService(context: context)
            
            let deleteContact = contactService.getById(id: self.contacts[indexPath.row].objectID)
            contactService.delete(id: (deleteContact?.objectID)!)
            contactService.saveChange()
            self.contacts.remove(at: indexPath.row)
            tableView.deleteRows(at:[indexPath as IndexPath], with: .fade)
        }
        let edit = UITableViewRowAction(style: .default , title: "Edit"){ action, index in
            self.performSegue(withIdentifier: "showEdit", sender: self.contacts[indexPath.row])
        }
        edit.backgroundColor = UIColor.gray
        return [delete,edit]

    }

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEdit" {
            let destView = segue.destination as! AddEditViewController
            destView.contact = sender as! Contact
        }
    }

}
