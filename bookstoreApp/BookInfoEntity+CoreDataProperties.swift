//
//  BookInfoEntity+CoreDataProperties.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 1/6/25.
//
//

import Foundation
import CoreData


extension BookInfoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookInfoEntity> {
        return NSFetchRequest<BookInfoEntity>(entityName: "BookInfoEntity")
    }

    @NSManaged public var authors: Data?
    @NSManaged public var contents: String?
    @NSManaged public var isbn: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var title: String?
    @NSManaged public var price: Double

}

extension BookInfoEntity : Identifiable {

}
