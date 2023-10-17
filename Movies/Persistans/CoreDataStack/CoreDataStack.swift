//
//  CoreDataStack.swift
//  Movies
//
//  Created by Андрей Коноплев on 16.10.2023.
//

import CoreData

protocol CoreDataStackProtocol: AnyObject {
    var mainContext: NSManagedObjectContext { get }
    var backgroundContext: NSManagedObjectContext { get }
    func saveContext (_ context: NSManagedObjectContext)
}

final class CoreDataStack: CoreDataStackProtocol {
    private let modelName: String

    init(modelName: String) {
        self.modelName = modelName
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    var backgroundContext: NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }

    func saveContext (_ context: NSManagedObjectContext) {
        guard context.hasChanges else { return }

        do {
            try context.save()
        } catch let error as NSError {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
