//
//  Recycle+CoreDataProperties.swift
//  CD_RECYCLE
//
//  Created by 백인찬 on 2021/05/06.
//
//

import Foundation
import CoreData


extension Recycle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recycle> {
        return NSFetchRequest<Recycle>(entityName: "Recycle")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int16
    @NSManaged public var material: String?
    @NSManaged public var recycleWay: String?
    @NSManaged public var classId: Int16
    @NSManaged public var classification: String?

}

extension Recycle : Identifiable {

}
