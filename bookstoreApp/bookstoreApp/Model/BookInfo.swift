//
//  BookInformation.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 12/31/24.
//
import Foundation

struct BookInfo {
    let authors: Data
    let contents: String
    let thumbnail: String
    let title: String
    let price: Double
    let isbn: String
}

extension BookInfo {
    init(from data: BookInformation.Data) {
        self.authors = try! JSONEncoder().encode(data.authors ?? [])
        self.contents = data.contents ?? ""
        self.thumbnail = data.thumbnail ?? ""
        self.title = data.title ?? ""
        self.price = data.price ?? 0.0
        self.isbn = data.isbn ?? ""
    }

    func decodedAuthors() -> [String] {
        return (try? JSONDecoder().decode([String].self, from: authors)) ?? []
    }
}
