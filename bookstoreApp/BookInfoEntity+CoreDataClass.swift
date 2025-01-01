//
//  BookInfoEntity+CoreDataClass.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 1/1/25.
//
//

import Foundation
import CoreData

@objc(BookInfoEntity)
public class BookInfoEntity: NSManagedObject {
    public static let className = "BookInfoEntity"
    
    public enum Key {
        static let authors = "authors"
        static let contents = "contents"
        static let thumbnail = "thumbnail"
        static let title = "title"
        static let isbn = "isbn"
    }
}
