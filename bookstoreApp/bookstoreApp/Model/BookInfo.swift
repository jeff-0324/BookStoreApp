//
//  BookInfo.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 12/29/24.
//
import Foundation

struct BookInfo: Codable {
    let documents: [Data]
}

extension BookInfo {
    struct Data: Codable {
        let authors: [String]?
        let contents: String?
        let title: String?
        let thumbnail: String?
    }
}
