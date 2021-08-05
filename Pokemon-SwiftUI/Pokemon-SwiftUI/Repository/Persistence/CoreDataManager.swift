//
//  CoreDataManager.swift
//  Pokemon-SwiftUI
//
//  Created by July on 5/08/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    var persistenceContainer: NSPersistentContainer
    
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistenceContainer.viewContext
    }
    
    private init() {
        self.persistenceContainer = NSPersistentContainer(name: "PokemonAppModel")
        self.persistenceContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize CoreData Stack: \(error)")
            }
        }
    }
    
    func getAllPokemons() -> [PokemonDAO] {
        let request: NSFetchRequest<PokemonDAO> = PokemonDAO.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print("CoreDataManager - getAllPokemons - Error: \(error.localizedDescription)")
            return []
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print("CoreDataManager - save - Error: \(error.localizedDescription)")
        }
    }
}
