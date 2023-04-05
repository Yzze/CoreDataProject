//
//  Presenter.swift
//  CoreDataProject
//
//  Created by Ян Жигурс on 05.04.2023.
//

import UIKit
import CoreData

class Presenter {
    
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var models = [Users]()
    
    func getAllItems() {
        do {
            models = try context?.fetch(Users.fetchRequest()) ?? models
        }
        catch {
            print("error")
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
            print("error")
        }
    }

    func deleteItem(item: Users) {
        context?.delete(item)
        do {
            try context?.save()
            getAllItems()
        }
        catch {
            print("error")
        }
    }
    
    func updateItem() {
        do {
            try context?.save()
            getAllItems()
        }
        catch {
            print("error")
        }
    }
}
