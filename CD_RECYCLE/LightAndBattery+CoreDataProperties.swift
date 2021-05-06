//
//  LightAndBattery+CoreDataProperties.swift
//  CD_RECYCLE
//
//  Created by 백인찬 on 2021/05/06.
//
//

import Foundation
import CoreData


extension LightAndBattery {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LightAndBattery> {
        return NSFetchRequest<LightAndBattery>(entityName: "LightAndBattery")
    }

    @NSManaged public var boroughId: Int16
    @NSManaged public var borough: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var address: String?
    @NSManaged public var detailAddress: String?
    @NSManaged public var type: String?

}

extension LightAndBattery : Identifiable {

}
