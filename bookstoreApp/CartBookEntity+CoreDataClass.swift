//
//  CartBookEntity+CoreDataClass.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 1/1/25.
//
//

import Foundation
import CoreData

@objc(CartBookEntity)
public class CartBookEntity: BookInfoEntity {

    public enum Key {
        static let addBookData = "addBookData"
        static let book = "book"
    }
}
