//
//  RecentBookEntity+CoreDataProperties.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 1/1/25.
//
//

import Foundation
import CoreData


extension RecentBookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecentBookEntity> {
        return NSFetchRequest<RecentBookEntity>(entityName: "RecentBookEntity")
    }

    @NSManaged public var recentBookData: Date?
    @NSManaged public var book: BookInfoEntity?

}
