//
//  BookInformation.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 12/31/24.
//
import Foundation

struct BookInfo {
    let authors: [String]
    let contents: String
    let thumbnail: String
    let title: String
    let isbn: String
}

extension BookInfo {
    init(from data: BookInformation.Data) {
        self.authors = data.authors ?? ["Unknown Author"]
        self.contents = data.contents ?? "No description available."
        self.thumbnail = data.thumbnail ?? ""
        self.title = data.title ?? "Untitled"
        self.isbn = data.isbn ?? "Unknown ISBN"
    }
}
