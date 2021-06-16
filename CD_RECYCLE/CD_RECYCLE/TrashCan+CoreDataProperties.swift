//
//  TrashCan+CoreDataProperties.swift
//  CD_RECYCLE
//
//  Created by 백인찬 on 2021/06/16.
//
//

import Foundation
import CoreData


extension TrashCan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrashCan> {
        return NSFetchRequest<TrashCan>(entityName: "TrashCan")
    }

    @NSManaged public var id: Int16
    @NSManaged public var borough: String?
    @NSManaged public var address: String?
    @NSManaged public var detailAddress: String?
    @NSManaged public var type: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}

extension TrashCan : Identifiable {

}
