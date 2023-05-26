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
        case isSuccess, message, code,data
    }
}

struct Book: Codable, Hashable {
    let bookId: Int
    let name: String
    let created_at: Date?
    let updated_at: Date?
    var count: Int?
    
}
