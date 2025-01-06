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
    
    // 코어 데이터 삭제
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "bookstoreApp")
        
        // 기존 스토어 삭제
        if let storeURL = container.persistentStoreDescriptions.first?.url {
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: storeURL.path) {
                do {
                    try fileManager.removeItem(at: storeURL)
                    print("Existing Core Data store deleted.")
                } catch {
                    print("Failed to delete store: \(error)")
                }
            }
        }
        
        // 새로운 스토어 로드
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // 에러 처리
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
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
            newBook.setValue(bookInfo.contents, forKey: BookInfoEntity.Key.contents)
            newBook.setValue(bookInfo.thumbnail, forKey: BookInfoEntity.Key.thumbnail)
            newBook.setValue(bookInfo.price, forKey: BookInfoEntity.Key.price)
            newBook.setValue(bookInfo.isbn, forKey: BookInfoEntity.Key.isbn)
            
            if let authorsData = try? JSONEncoder().encode(bookInfo.authors) {
                newBook.authors = authorsData
            }
            
            try context.save()
            print("데이터 생성 성공")
            return newBook
        } catch {
            print("데이터 생성 실패: \(error)")
            return nil
        }
    }
    
    func fetchBookInfo() -> [BookInfo] {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<BookInfoEntity> = BookInfoEntity.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.map { entity in
                return BookInfo(
                    authors: entity.authors ?? Data(),
                    contents: entity.contents ?? "",
                    thumbnail: entity.thumbnail ?? "",
                    title: entity.title ?? "",
                    price: entity.price,
                    isbn: entity.isbn ?? ""
                )
            }
        } catch {
            print("Failed to fetch book info: \(error)")
            return []
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
    
    func addToCartBooks(book: BookInfo, quantity: Int16) {
        let context = CoreDataManager.shared.context
        
        // 1. BookInfoEntity에 저장
        guard let savedBook = saveBookInfo(book) else {
            print("Failed to save BookInfo")
            return
        }
        
        // 2. CartBookEntity 생성 및 관계 설정
        let cartEntity = CartBookEntity(context: context)
        cartEntity.addBookData = Date()
        cartEntity.book = savedBook
        
        do {
            try context.save()
            print("Saved to CartBookEntity successfully!")
        } catch {
            print("Failed to save to CartBookEntity: \(error)")
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
    
    //saveBookInfo에서 반환된 BookInfoEntity를 RecentBookEntity와 연결
    func addToRecentBooks(book: BookInfo) {
        let context = CoreDataManager.shared.context
        
        // 1. BookInfoEntity에 저장
        guard let savedBook = saveBookInfo(book) else {
            print("Failed to save BookInfo")
            return
        }
        
        // 2. RecentBookEntity 생성 및 관계 설정
        let recentEntity = RecentBookEntity(context: context)
        recentEntity.recentBookData = Date()
        recentEntity.book = savedBook
        
        do {
            try context.save()
            print("Saved to RecentBookEntity successfully!")
        } catch {
            print("Failed to save to RecentBookEntity: \(error)")
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
