//
//  ContactService.swift
//  Phone Contacts
//
//  Created by Eang Pheara on 1/4/17.
//  Copyright © 2017 Eang Pheara. All rights reserved.
//

import Foundation
import CoreData


class ContactService{
    var context : NSManagedObjectContext
    init(context: NSManagedObjectContext){
        self.context = context
    }
    //Get all
    func getAll() -> [Contact]{
        return get(withPredicate : NSPredicate(value: true))
    }
    // Get
    func get(withPredicate queryPredicate: NSPredicate) -> [Contact]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        
        fetchRequest.predicate = queryPredicate
        
        do {
            let response = try context.fetch(fetchRequest)
            return response as! [Contact]
            
        } catch let error as NSError {
            // failure
            print(error)
            return [Contact]()
        }
    }
    // Create
    func create(name: String, phone: String, email: String, image: String) -> Contact{
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Contact", into : context) as! Contact
        newItem.name = name
        newItem.phone = phone
        newItem.email = email
        newItem.image = image
        return newItem
    }
    
    //Update
    
    func update(updateContact: Contact){
        let contact = getById(id: updateContact.objectID)
        contact?.name = updateContact.name
        contact?.phone = updateContact.phone
        contact?.email = updateContact.email
        contact?.image = updateContact.image
    }
    
    //Save Change
    
    func saveChange() {
        do{
            try context.save()
            
        }catch{
            print("Error")
        }
    }
    // get by id
    func getById(id: NSManagedObjectID)-> Contact?{
        return context.object(with: id) as? Contact
    }
    // delete
    func delete(id: NSManagedObjectID){
        if let contactToDelete = getById(id: id){
            context.delete(contactToDelete)
        }
    }

}
