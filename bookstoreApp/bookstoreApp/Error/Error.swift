//
//  Error.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 12/30/24.
//
import Foundation

enum NetworkError: Error {
    case invalidUrl
    case dataFetchFail
    case decodingFail
}
