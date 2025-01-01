//
//  RecentBookEntity+CoreDataClass.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 1/1/25.
//
//

import Foundation
import CoreData

@objc(RecentBookEntity)
public class RecentBookEntity: BookInfoEntity {

    public enum Key {
        static let recentBookData = "recentBookData"
        static let book = "book"
    }
}
