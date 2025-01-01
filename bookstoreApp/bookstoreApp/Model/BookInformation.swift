//
//  BookInfo.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 12/29/24.
//
import Foundation

struct BookInformation: Codable {
    let documents: [Data]
}

extension BookInformation {
    struct Data: Codable {
        let authors: [String]?
        let contents: String?
        let title: String?
        let thumbnail: String?
        let isbn: String?
    }
}
