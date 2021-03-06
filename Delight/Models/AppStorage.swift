//
//  PreviewModel.swift
//  Delight
//

import CoreData

class AppStorage: NSPersistentContainer {

    private static let model = NSManagedObjectModel.mergedModel(from: nil)!

    private init(name: String) {
        super.init(name: name, managedObjectModel: AppStorage.model)
    }

    static let shared: AppStorage = {
        let container = AppStorage(name: "Delight")
        container.loadPersistentStores { (_, error) in
            precondition(error == nil, "Unresolved error \(error!)")
        }
        return container
    }()

    #if DEBUG
    static var forPreviewing: AppStorage {
        let container = AppStorage(name: "Delight")
        container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores { (_, error) in
            precondition(error == nil, "Unresolved error \(error!)")
        }
        return container
    }
    #endif

    func save() {
        guard viewContext.hasChanges else { return }
        try! viewContext.save()
    }

}
