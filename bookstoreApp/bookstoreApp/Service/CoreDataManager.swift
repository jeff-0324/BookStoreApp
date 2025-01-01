//
//  CoreDataManager.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 12/31/24.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    var container: NSPersistentContainer {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer
    }
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    var bookInfomationEntity: NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: BookInfoEntity.className, in: context)
    }

    //MARK: - 책의 정보를 저장
    func saveBookInfo(_ bookInfo: BookInfo) -> BookInfoEntity? {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<BookInfoEntity> = BookInfoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isbn == %@", bookInfo.isbn)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let existingBook = results.first {
                return existingBook
            }
            
            let newBook = BookInfoEntity(context: context)
            newBook.setValue(bookInfo.title, forKey: BookInfoEntity.Key.title)
            newBook.setValue(bookInfo.authors, forKey: BookInfoEntity.Key.authors)
            newBook.setValue(bookInfo.contents, forKey: BookInfoEntity.Key.contents)
            newBook.setValue(bookInfo.thumbnail, forKey: BookInfoEntity.Key.thumbnail)
            newBook.setValue(bookInfo.isbn, forKey: BookInfoEntity.Key.isbn)
            try context.save()
            print("데이터 생성 성공")
            return newBook
        } catch {
            print("데이터 생성 실패")
            return nil
        }
    }
    
    //MARK: - 장바구니에 저장
    func addToCart(book: BookInfoEntity) {
        let context = CoreDataManager.shared.context
        let cartBook = CartBookEntity(context: context)
        cartBook.book = book
        cartBook.addBookData = Date()
        
        do {
            try context.save()
            print("책을 담는데 성공했습니다.")
        } catch {
            print("책을 담는데 실패했습니다.")
        }
    }

    //MARK: - 최근 선택한 책의 정보를 저장
    func addToRecent(book: BookInfoEntity) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<RecentBookEntity> = RecentBookEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "book == %@", book)
        
        do {
            let results = try context.fetch(fetchRequest)
            let recentBook: RecentBookEntity
            
            if let existingRecentBook = results.first {
                recentBook = existingRecentBook
            } else {
                recentBook = RecentBookEntity(context: context)
                recentBook.book = book
            }
            
            recentBook.recentBookData = Date()
            try context.save()
            print("최근 본 책이 저장되었습니다.")
        } catch {
            print("최근 본 책이 저장되는데 실패했습니다.")
        }
    }
    
    //MARK: - 장바구니에 담긴 책을 조회
    func fetchCartBooks() -> [CartBookEntity] {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CartBookEntity> = CartBookEntity.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("담긴 책을 조회하는데 실패했습니다.")
            return []
        }
    }
    
    //MARK: - 최근 본 책을 조회
    func fetchRecentBooks() -> [RecentBookEntity] {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<RecentBookEntity> = RecentBookEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: RecentBookEntity.Key.recentBookData, ascending: false)]
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("최근 본 책을 조회하는데 실패했습니다.")
            return []
        }
    }
    
    
}
