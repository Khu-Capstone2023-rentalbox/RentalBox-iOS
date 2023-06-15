//
//  fixture.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/10.
//

import Foundation

struct Fixture: Codable,Identifiable {
    let id: UUID?
    var isSuccess: Bool
    var message: String
    var code: Int
    var data: [Book]
    
    enum codingKeys: String, CodingKey {
        case isSuccess, message, code, data
    }
}

struct Book: Codable, Hashable {
    var bookId: Int?
    var name: String
    var created_at: Date?
    var updated_at: Date?
    var count: Int?
    var rentals: [Rental]?
    
    enum codingKeys: CodingKey {
        case bookId, name, created_at, updated_at, count, rentals
    }
}

struct Rental: Codable, Hashable {
    var owner_name: String
    var return_time: String
    
    enum codingKeys: String, CodingKey {
        case owner_name, return_time
    }
}

struct FixtureDetail: Codable, Hashable {
    var isSuccess: Bool
    var message: String
    var code: Int
    var data: Book?
    enum codingKeys: CodingKey {
        case isSuccess, message, code, data
    }
}

struct Rent: Codable, Hashable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var data: String?
    enum codingKeys: CodingKey {
        case isSuccess, code, message, data
    }
}

struct MypageFixture: Codable, Hashable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var data: MypageData
    enum codingKeys: CodingKey {
        case isSuccess, code, message, data
    }
}

struct MypageData: Codable, Hashable {
    var userName: String
    var list: [MypageList]
    enum codingKeys: CodingKey {
        case userName, list
    }
}

struct MypageList: Codable, Hashable {
    var itemName: String
    var itemId: Int
    var rentalTime: String
    enum codingKeys: CodingKey {
        case itemName, itemId, rentalTime
    }
}

struct MypageRentFixture: Codable, Hashable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var data: [MypageRentFixtureData]
    
    enum CodingKeys: CodingKey {
        case isSuccess
        case code
        case message
        case data
    }
}

struct MypageRentFixtureData: Codable, Hashable {
    var itemName: String
    var rentalDate: String
    var overDueDate: String
    var charge: Int
    
    enum CodingKeys: CodingKey {
        case itemName
        case rentalDate
        case overDueDate
        case charge
    }
}
