//
//  CartBookEntity+CoreDataProperties.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 1/1/25.
//
//

import Foundation
import CoreData


extension CartBookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartBookEntity> {
        return NSFetchRequest<CartBookEntity>(entityName: "CartBookEntity")
    }

    @NSManaged public var addBookData: Date?
    @NSManaged public var book: BookInfoEntity?

}
