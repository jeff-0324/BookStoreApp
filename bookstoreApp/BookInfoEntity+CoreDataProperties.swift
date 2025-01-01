//
//  BookInfoEntity+CoreDataProperties.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 1/1/25.
//
//

import Foundation
import CoreData


extension BookInfoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookInfoEntity> {
        return NSFetchRequest<BookInfoEntity>(entityName: "BookInfoEntity")
    }

    @NSManaged public var authors: [String]?
    @NSManaged public var contents: String?
    @NSManaged public var thumbnail: Data?
    @NSManaged public var title: String?
    @NSManaged public var isbn: String?

}

extension BookInfoEntity : Identifiable {

}
