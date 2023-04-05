//
//  Presenter.swift
//  CoreDataProject
//
//  Created by Ян Жигурс on 05.04.2023.
//

import UIKit
import CoreData

class Presenter {
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var models = [Users]()
    
    func getAllItems() {
        do {
            models = try context?.fetch(Users.fetchRequest()) ?? models
        }
        catch {
            //error
        }
    }

    func createItem(name: String) {
        let newItem = Users(context: context ?? NSManagedObjectContext())
        newItem.name = name
        
        do {
            try context?.save()
            getAllItems()
        }
        catch {
            
        }
    }

    func deleteItem(item: Users) {
        context?.delete(item)
        
        do {
            try context?.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
    func updateItem() {
        
        do {
            try context?.save()
            getAllItems()
        }
        catch {
            
        }
    }
}
