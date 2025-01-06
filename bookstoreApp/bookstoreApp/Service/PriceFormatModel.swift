//
//  PriceFormatModel.swift
//  bookstoreApp
//
//  Created by jae hoon lee on 1/6/25.
//
import Foundation

// 숫자를 원화로 바꿔주는 모델
struct PriceFormatModel {

    // 1000 단위 구분
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()

    static func wonFormat(_ number: Int) -> String {
        let result = formatter.string(from: NSNumber(value: number)) ?? "0"
        return result + "원"
    }
}
