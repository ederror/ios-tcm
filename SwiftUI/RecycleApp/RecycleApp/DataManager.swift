//
//  DataManager.swift
//  RecycleApp
//
//  Created by 백인찬 on 2021/05/08.
//

import Foundation
import CoreData
import SwiftCSV

class DataManager {
    // File Path
    let filePath = Bundle.main.url(forResource: "시트 1-표 2.csv", withExtension: nil)!
    let filePath2 = Bundle.main.url(forResource: "_서울특별시 14개 구 폐형광등폐건전지 분리수거함 위치.csv", withExtension: nil)!
    
    func dataLoad() {
        let request: NSFetchRequest<Recycle> = Recycle.fetchRequest()
        if PersistenceManager.shared.count(request: request)! == 0 {
            self.insertAll()
        }

        let LBrequest: NSFetchRequest<LightAndBattery> = LightAndBattery.fetchRequest()
        print(PersistenceManager.shared.count(request: LBrequest)!)
        
//        self.deleteAll()
    }
    
    func insertAll() {
        // insert Recycle
        do {
            let csvFile: CSV = try CSV(url: filePath)
            for item in csvFile.namedRows {
                let recycleItem = RecycleItem(name: item["품목"], id: Int16(item["Id"]!)!, material: item["재질"], recycleWay: item["배출방법"], classId: Int16(item["구분_id"]!)!, classification: item["구분"])
                PersistenceManager.shared.insertRecycleItem(item: recycleItem)
            }
        } catch {
            print("parseError")
        }
        
        // insert LB
        do {
            let csvFile2: CSV = try CSV(url: filePath2)
            for item in csvFile2.namedRows {
                var latitude: Double = 0.0
                var longitude: Double = 0.0
                if let lat = item["위도"], let doubleLat = Double(lat) {
                    latitude = doubleLat
                }
                if let long = item["경도"], let doubleLong = Double(long) {
                    longitude = doubleLong
                }
                let LBItem = LightAndBatteryItem(boroughId: Int16(item["연번"]!) as! Int16, borough: item["구"], latitude: latitude, longitude: longitude, address: item["주소"], detailAddress: item["세부 위치"], type: item["유형"])
                
                PersistenceManager.shared.insertLightAndBatteryItem(item: LBItem)
            }
        } catch {
            print("parseError 2 \(error)")
        }
        
    }
    func deleteAll() {
        let request: NSFetchRequest<Recycle> = Recycle.fetchRequest()
        if PersistenceManager.shared.deleteAll(request: request, entityName: "Recycle") {
            print("clean")
            print("After deleteAll RECYCLE in DB : \(PersistenceManager.shared.count(request: request)!)")
        } else {
            print("deleteAll failed")
        }
        
        let LBrequest: NSFetchRequest<LightAndBattery> = LightAndBattery.fetchRequest()
        if PersistenceManager.shared.deleteAll(request: LBrequest, entityName: "LightAndBattery") {
            print("clean")
            print("After deleteAll LIGHT AND BATTERY in DB : \(PersistenceManager.shared.count(request: LBrequest)!)")
        } else {
            print("deleteAll failed")
        }
        
    }
}


class PersistenceManager {
    static var shared: PersistenceManager = PersistenceManager()
    
    lazy var persistenceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RecycleApp")
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistenceContainer.viewContext
    }
    
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        do {
            let fetchResult = try self.context.fetch(request)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    @discardableResult
    func insertRecycleItem(item: RecycleItem) -> Bool {
        let entity = NSEntityDescription.entity(forEntityName: "Recycle", in: self.context)
        
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: self.context)
            
            managedObject.setValue(item.name, forKey: "name")
            managedObject.setValue(item.id, forKey: "id")
            managedObject.setValue(item.material, forKey: "material")
            managedObject.setValue(item.recycleWay, forKey: "recycleWay")
            managedObject.setValue(item.classId, forKey: "classId")
            managedObject.setValue(item.classification, forKey: "classification")
            
            do {
                try self.context.save()
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        } else {
            return false
        }
    }
    
    @discardableResult
    func insertLightAndBatteryItem(item: LightAndBatteryItem) -> Bool {
        let entity = NSEntityDescription.entity(forEntityName: "LightAndBattery", in: self.context)
        
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: self.context)
            
            managedObject.setValue(item.boroughId, forKey: "boroughId")
            managedObject.setValue(item.borough, forKey: "borough")
            managedObject.setValue(item.address, forKey: "address")
            managedObject.setValue(item.detailAddress, forKey: "detailAddress")
            managedObject.setValue(item.latitude, forKey: "latitude")
            managedObject.setValue(item.longitude, forKey: "longitude")
            managedObject.setValue(item.type, forKey: "type")
            
            do {
                try self.context.save()
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        } else {
            return false
        }
    }
    
    @discardableResult
    func delete(object: NSManagedObject) -> Bool {
        self.context.delete(object)
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult
    func deleteAll<T: NSManagedObject>(request: NSFetchRequest<T>, entityName: String) -> Bool {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let delete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try self.context.execute(delete)
            return true
            
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func count<T: NSManagedObject>(request: NSFetchRequest<T>) -> Int? {
        do {
            let count = try self.context.count(for: request)
            return count
        } catch {
            return nil
        }
    }


}


